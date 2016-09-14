pg_plan_tree_dot
================

pg_plan_tree_dot is a PostgreSQL extension which visualizes a plan tree using Graphviz.

As you know, the EXPLAIN command displays the execution plan that PostgreSQL's planner/optimizer generates for the supplied statement.
However the result of this command is rough.

pg_plan_tree_dot allows you to generate a .dot file from the given SQL query, and then you convert the ouput .dot file into the plan tree graph using the "dot" command for Graphviz. 

Requirements
============

- Install Graphviz
- Install PostgreSQL 9.x

Tested on:

- PostgreSQL 9.0.23, 9.1.23, 9.2.18, 9.3.14, 9.4.9, 9.5.4, and 9.6rc1 under x86-64 CentOS 6.x

Building
========

First, acquire the source code by cloning the git repository.

    $ git clone https://github.com/nminoru/pg_plan_tree_dot

Next, input the following commadns.

    $ cd pg_plan_tree_dot
    $ make
    $ make install

Usage 
=====

    CREATE EXTENSION pg_plan_tree_dot;

    SELECT generate_plan_tree_dot('sql', 'output.dot');

    dot -Tpng output.dot -o output.png
