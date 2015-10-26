CC := g++ # This is the main compiler

BUILD_DIR := build
TEST_DIR := test
SRC_DIR := src
PROGRAM_NAME := program8
TEST_NAME := test_$(PROGRAM_NAME)
INC_DIR := include
CFLAGS := -Wall -Werror -std=c++11
INC := -I $(INC_DIR)


.PHONY: test
test: bin/test
	bin/test

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)

run: main
	bin/$(PROGRAM_NAME)

main: $(BUILD_DIR)/main.o $(BUILD_DIR)/$(PROGRAM_NAME).o
	$(CC) -o bin/$(PROGRAM_NAME) $(BUILD_DIR)/main.o $(BUILD_DIR)/$(PROGRAM_NAME).o $(CFLAGS) $(INC)

$(BUILD_DIR)/main.o: $(SRC_DIR)/main.cpp $(INC_DIR)/$(PROGRAM_NAME).h
	@mkdir -p $(BUILD_DIR)
	$(CC) -o $(BUILD_DIR)/main.o -c $(SRC_DIR)/main.cpp $(CFLAGS) $(INC)


bin/test: $(BUILD_DIR)/$(PROGRAM_NAME).o $(BUILD_DIR)/$(TEST_NAME).o
	$(CC) -o bin/test $(BUILD_DIR)/$(PROGRAM_NAME).o $(BUILD_DIR)/tester.o $(BUILD_DIR)/$(TEST_NAME).o

$(BUILD_DIR)/$(PROGRAM_NAME).o: $(SRC_DIR)/$(PROGRAM_NAME).cpp $(INC_DIR)/$(PROGRAM_NAME).h
	@mkdir -p $(BUILD_DIR)
	$(CC) -o $(BUILD_DIR)/$(PROGRAM_NAME).o -c $(SRC_DIR)/$(PROGRAM_NAME).cpp $(CFLAGS) $(INC)

$(BUILD_DIR)/$(TEST_NAME).o: $(BUILD_DIR)/tester.o $(TEST_DIR)/$(TEST_NAME).cpp $(INC_DIR)/catch.hpp $(INC_DIR)/$(PROGRAM_NAME).h
	$(CC) -o $(BUILD_DIR)/$(TEST_NAME).o -c $(TEST_DIR)/$(TEST_NAME).cpp $(CFLAGS) $(INC)

$(BUILD_DIR)/tester.o: $(TEST_DIR)/tester.cpp $(INC_DIR)/catch.hpp
	$(CC) -o $(BUILD_DIR)/tester.o -c $(TEST_DIR)/tester.cpp $(CFLAGS) $(INC)
