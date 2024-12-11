# Executable Filename
TARGET_EXEC := SFFTAG.x86

# Directories
BIN_DIR     := ./bin
BUILD_DIR   := ./build
SRC_DIR     := ./src
INC_DIR     := ./include

# Files
SRCS        := $(wildcard $(SRC_DIR)/*.cpp)
OBJS        := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))
DEPS        := $(OBJS:.o=.d)

# C++ Compile Rules
CXX         := g++
CXXFLAGS    := -std=c++14 -Wextra -Wall -Wfloat-equal -Wundef
CPPFLAGS    := -MMD -MP
INC_FLAGS   := -I$(INC_DIR)
LDFLAGS     := $(INC_FLAGS)

# Phony Targets
.PHONY : clean

# Targets

all: $(BIN_DIR)/$(TARGET_EXEC)

$(BIN_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CXX) $(CPPFLAGS) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BIN_DIR)

clean:
	rm -r $(BIN_DIR)
	rm -r $(BUILD_DIR)

-include $(DEPS)
