.POSIX:
.PHONY: all clean

SOURCE = efi.c
TARGET = BOOTX64.EFI

CC = clang \
	-target x86_64-unknown-windows \
	-fuse-ld=lld-link \
	-Wl,-subsystem:efi_application \
	-Wl,-entry:efi_main

CFLAGS = \
	-std=c17 \
	-Wall \
	-Wextra \
	-Wpedantic \
	-mno-red-zone \
	-ffreestanding \
	-nostdlib

DISK_IMG_FOLDER = UEFI-GPT-image-creator
DISK_IMG_PGM    = write_gpt

all: $(DISK_IMG_FOLDER)/$(DISK_IMG_PGM) $(TARGET)
	cd $(DISK_IMG_FOLDER)

$(DISK_IMG_FOLDER)/$(DISK_IMG_PGM):
	cd $(DISK_IMG_FOLDER) && $(MAKE)

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $@ $<
	cp $(TARGET) $(DISK_IMG_FOLDER); \
	cd $(DISK_IMG_FOLDER) && ./$(DISK_IMG_PGM) $(DISK_FLAGS); \
	cd .. && cp $(DISK_IMG_FOLDER)/test.hdd uefi-latency-guest.raw; \
	qemu-img convert -f raw -O qcow2 uefi-latency-guest.raw uefi-latency-guest.qcow2

clean:
	rm -rf $(TARGET)
