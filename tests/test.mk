TEST_SRC = $(wildcard tests/test_*.cc)
TEST = $(patsubst tests/test_%.cc, tests/test_%, $(TEST_SRC))

# -ltcmalloc_and_profiler
LDFLAGS = -Wl,-rpath,$(DEPS_PATH)/lib $(PS_LDFLAGS_SO) -pthread
tests/% : tests/%.cc build/libps.a
	$(CXX) $(CFLAGS) $(LIBS) -MM -MT tests/$* $< >tests/$*.d
	$(CXX) $(CFLAGS) $(LIBS) -o $@ $(filter %.cc %.a, $^) $(LDFLAGS)

-include tests/*.d
