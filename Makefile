# pg_plan_tree_dot/Makefile

MODULE_big = pg_plan_tree_dot
OBJS = pg_plan_tree_dot.o plan_tree_view.o 

EXTENSION = pg_plan_tree_dot
DATA = pg_plan_tree_dot--1.0.sql pg_plan_tree_dot--unpackaged--1.0.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

# CFLAGS += -DCUSTOM_PLAN

CXXFLAGS = $(filter-out -Wmissing-prototypes -Wdeclaration-after-statement -fexcess-precision=standard%, $(CFLAGS))

COMPILER = $(CXX) $(CXXFLAGS)

%.o : %.cpp
ifdef DEPDIR
	@if test ! -d $(DEPDIR); then mkdir -p $(DEPDIR); fi
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $< -MMD -MP -MF $(DEPDIR)/$(*F).Po
else
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<
endif

