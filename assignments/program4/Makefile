CC := g++ # This is the main compiler
# CC := clang --analyze # and comment out the linker last line for sanity
SRCDIR := src
BUILDDIR := build
TARGET := bin/runner
 
SRCEXT := cpp

SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))

TEST_TARGET := test/bin/tester
TEST_DIR := test
TEST_BUILD_DIR := $(TEST_DIR)/build
TEST_SOURCES := $(shell find $(TEST_DIR) -type f -name *.$(SRCEXT))
TEST_OBJECTS := $(patsubst $(TEST_DIR)/%,$(TEST_BUILD_DIR)/%,$(TEST_SOURCES:.$(SRCEXT)=.o))

CFLAGS := -g -Wall
LIB :=
INC := -I include

$(TARGET): $(OBJECTS)
	@echo " Linking..."
	@echo " $(CC) $^ -o $(TARGET) $(LIB)"; $(CC) $^ -o $(TARGET) $(LIB)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<"; $(CC) $(CFLAGS) $(INC) -c -o $@ $<

# Tests
.PHONY: test
test: $(TEST_TARGET)
	$(TEST_TARGET)

$(TEST_TARGET): $(TEST_OBJECTS)
	@echo " Linking..."
	@echo " $(CC) $^ -o $(TEST_TARGET) $(LIB)"; $(CC) $^ -o $(TEST_TARGET) $(LIB)

$(TEST_BUILD_DIR)/%.o: $(TEST_DIR)/%.$(SRCEXT)
	@mkdir -p $(TEST_BUILD_DIR)
	@echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<"; $(CC) $(CFLAGS) $(INC) -c -o $@ $<

.PHONY: clean
clean:
	@echo " Cleaning..."; 
	@echo " $(RM) -r $(BUILDDIR) $(TARGET)"; $(RM) -r $(BUILDDIR) $(TARGET)
	@echo " $(RM) -r $(TEST_BUILD_DIR) $(TEST_TARGET)"; $(RM) -r $(TEST_BUILD_DIR) $(TEST_TARGET)
