/*-------------------------------------------------------------------------
 *
 * pg_plan_tree_dot.c
 *
 * Copyright (c) 2014-2016 Minoru NAKAMURA <nminoru@nminoru.jp>
 *
 *-------------------------------------------------------------------------
 */
#include "postgres.h"

#include <stdio.h>

#include "executor/execdesc.h"
#include "executor/executor.h"
#include "fmgr.h"
#include "miscadmin.h"
#include "nodes/nodes.h"
#include "nodes/pg_list.h"
#include "nodes/plannodes.h"
#include "optimizer/planner.h"
#include "tcop/dest.h"
#include "tcop/tcopprot.h"
#include "utils/builtins.h"
#include "utils/memutils.h"
#include "utils/snapmgr.h"

#include "pg_plan_tree_dot.h"


PG_MODULE_MAGIC;

extern void _PG_init(void);

static void output_sql_query(const char *sql, const char *filename, bool simplify);
static void output_plan_tree(const char *title, const char *sql, const void *obj, FILE *file,  bool simplify);

/*
 *
 */
PG_FUNCTION_INFO_V1(generate_plan_tree_dot);
Datum
generate_plan_tree_dot(PG_FUNCTION_ARGS)
{
	text *sql, *filename;
	char *sql_str, *filename_str;
	bool  simplify;
	MemoryContext tempcontext, oldcontext;

	sql			= PG_GETARG_TEXT_P(0);
	filename	= PG_GETARG_TEXT_P(1);
	simplify	= PG_GETARG_BOOL(2);

	tempcontext = AllocSetContextCreate(CurrentMemoryContext,
										"print_plan_tree temporary context",
										ALLOCSET_DEFAULT_MINSIZE,
										ALLOCSET_DEFAULT_INITSIZE,
										ALLOCSET_DEFAULT_MAXSIZE);

	oldcontext = MemoryContextSwitchTo(tempcontext);

	sql_str			= TextDatumGetCString(sql);
	filename_str	= TextDatumGetCString(filename);

	output_sql_query(sql_str, filename_str, simplify);

	pfree(filename_str);
	pfree(sql_str);

	MemoryContextSwitchTo(oldcontext);
	MemoryContextDelete(tempcontext);

	PG_RETURN_VOID();
}

/*
 *
 */
static void
output_sql_query(const char *sql, const char *filename, bool simplify)
{
	List		   *raw_parsetree_list;
	DestReceiver   *dest;
	ListCell	   *lc1;
	FILE		   *file;

	file = fopen(filename, "w");
	if (file == NULL)
		elog(ERROR, "cannot create \"%s\"", filename);

	raw_parsetree_list = pg_parse_query(sql);

	dest = CreateDestReceiver(DestNone);

	foreach(lc1, raw_parsetree_list)
	{
		Node	   *parsetree = (Node *) lfirst(lc1);
		List	   *stmt_list;
		ListCell   *lc2;

		stmt_list = pg_analyze_and_rewrite(parsetree,
										   sql,
										   NULL,
										   0);
		stmt_list = pg_plan_queries(stmt_list, 0, NULL);

		foreach(lc2, stmt_list)
		{
			Node	   *stmt = (Node *) lfirst(lc2);

			if (IsA(stmt, PlannedStmt) &&
				((PlannedStmt *) stmt)->utilityStmt == NULL)
			{
				QueryDesc  *qdesc;

				qdesc = CreateQueryDesc((PlannedStmt *) stmt,
										sql,
										GetActiveSnapshot(), NULL,
										dest, NULL, 0);
				
				output_plan_tree("Plan Tree", sql, qdesc->plannedstmt, file, simplify);

				FreeQueryDesc(qdesc);
			}
		}
	}

	fclose(file);
}

/*
 *
 */
static void
output_plan_tree(const char *title, const char *sql, const void *obj, FILE *file, bool simplify)
{
	char *p, *buffer, *result;

	/* buffer = (char *) palloc(strlen(title) + strlen(debug_query_string) + 3); */
	buffer = (char *) palloc(strlen(title) + strlen(sql) + 3);

	sprintf(buffer, "%s: %s", title, sql);
	
	for (p = buffer; *p ; p++)
	{
		switch (*p)
		{
			case '\t':
				*p = ' ';
				break;
			case '\n':
				*p = ' ';
				break;
			case '"':
				*p = '\'';
				break;
			default:
				break;
		}
	}

	result = get_plan_tree_dot_string(buffer, obj, simplify);

	if (result)
	{
		fputs(result, file);
		fputs("\n", file);
		fflush(file);
	}

	if (result)
		pfree(result);

	if (buffer)
		pfree(buffer);
}
