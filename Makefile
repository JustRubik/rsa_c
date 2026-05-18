# SETUP
SHELL := bash
CC := gcc

BUILD ?= debug
BUILD_DIR := build/$(BUILD)

TARGET := $(BUILD_DIR)/rsa_c

# SOURCES
SRC := $(wildcard src/*.c)
OBJ := $(patsubst src/%.c,$(BUILD_DIR)/%.o,$(SRC))

# FLAGS
CPPFLAGS := -Iinclude

COMMON_FLAGS := -std=c11 \
                -Wall -Wextra -Wpedantic \
                -Wshadow -Wconversion \
                -ffunction-sections -fdata-sections

# SANITIZE_FLAGS := -fsanitize=address -fsanitize=undefined

DEBUG_FLAGS := -Og -g3

RELEASE_FLAGS := -O2 -DNDEBUG

TEST_FLAGS := -O0 -g3 --coverage

LDFLAGS := -Wl,--gc-sections
LDLIBS :=

# BUILD MODES
ifeq ($(BUILD),debug)
	CFLAGS := $(COMMON_FLAGS) $(DEBUG_FLAGS)
endif

ifeq ($(BUILD),release)
	CFLAGS := $(COMMON_FLAGS) $(RELEASE_FLAGS)
endif

ifeq ($(BUILD),test)
	CFLAGS := $(COMMON_FLAGS) $(TEST_FLAGS)
endif

# RULES

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $@ $(LDFLAGS) $(LDLIBS) $(if $(filter release,$(BUILD)),,$(SANITIZE_FLAGS))

$(BUILD_DIR)/%.o: src/%.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

# UTILITIES

.PHONY: all build run debug release test clean

build: 
	mkdir -p build

run: all
	./$(TARGET)

debug:
	$(MAKE) BUILD=debug

release:
	$(MAKE) BUILD=release

test:
	$(MAKE) BUILD=test

clean:
	rm -rf build

-include $(OBJ:.o=.d)
