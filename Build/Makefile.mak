BUILD_DIR      = Build
MAKEFILE       = $(BUILD_DIR)/Makefile.mak
TARGET         = Release

OUT_DIR = _out
OBJ_DIR = $(OUT_DIR)/$(TARGET)
BIN_DIR = $(OBJ_DIR)/bin
OUT_EXE = $(BIN_DIR)/out.exe

BUILD_OBJS  =
INCLUDE_DIR = -I./ -I$(BUILD_DIR)

TARGET_MAKEFILE = $(BUILD_DIR)/$(TARGET).mak

include $(TARGET_MAKEFILE)

C_COMPILER = distcc /usr/bin/gcc
C_FLAGS    = -std=c99 -Wall
C_INCLUDE  = $(INCLUDE_DIR)

COMPILE    = $(C_COMPILER) -c
LINK       = $(C_COMPILER)

.PHONY: image
image:
	@$(MAKE) compile_and_link -f $(MAKEFILE)

MKDIR = mkdir -p

$(BIN_DIR) \
$(OBJ_DIR):
	@$(MKDIR) $@

.PHONY: $(OBJ_DIR)/%.o
$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	@$(MKDIR) $(@D)
	@echo $(C_INCLUDE) >> $@.via
	@echo "Compiling" $<
	@$(COMPILE) $(C_FLAGS) @$@.via $< -o $@

%.h:
	@

.PHONY: compile_and_link
compile_and_link: compile link

.PHONY: compile
compile: $(sort $(BUILD_OBJS)) | $(BIN_DIR)

.PHONY: link
link: $(BUILD_OBJS)
	@$(LINK) $(C_FLAGS) -o $(OUT_EXE) $^

.PHONY: clean
clean:
	@rm -rf $(OUT_DIR)
