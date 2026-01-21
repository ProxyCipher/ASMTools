OUT_DIR := out
SRCS := $(wildcard *.s)
PROGS := $(patsubst %.s,$(OUT_DIR)/%,$(SRCS))

.PHONY: all compile clean
all: $(PROGS)
compile: all

$(OUT_DIR)/%: $(OUT_DIR)/%.o | $(OUT_DIR)
	ld -m elf_x86_64 -o $@ $<

$(OUT_DIR)/%.o: %.s | $(OUT_DIR)
	nasm -f elf64 -o $@ $<

$(OUT_DIR):
	mkdir -p $@

clean:
	rm -rf $(OUT_DIR)