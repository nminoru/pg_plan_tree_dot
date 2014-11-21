/*-------------------------------------------------------------------------
 *
 * pg_plan_tree_dot.h
 *
 * Copyright (c) 2014 Minoru NAKAMURA <nminoru@nminoru.jp>
 *
 *-------------------------------------------------------------------------
 */
#ifndef PG_PLAN_TREE_DOT_H
#define PG_PLAN_TREE_DOT_H

#ifdef __cplusplus
extern "C" {
#endif

extern char *get_plan_tree_dot_string(const char *title, const void *obj);

#ifdef __cplusplus
};
#endif

#endif /* PG_PLAN_TREE_DOT_H */
