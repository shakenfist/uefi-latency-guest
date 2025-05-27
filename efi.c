#include "efi.h"

// A simple EFI program which responds to keyboard input by cycling through
// various colours because that's easy to detect from the client. This is used
// to measure round trip time / latency for SPICE connections through a proxy.

// EFI Image Entry Point
EFI_STATUS EFIAPI efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle;	// Prevent compiler warning due to unused argument

    // Start state is a blue screen
    uint8_t bgcolour = EFI_BLUE;

    while (TRUE) {
        uint8_t fgcolour = (bgcolour == EFI_BLACK ? EFI_WHITE : EFI_BLACK);

        // Set colours
        SystemTable->ConOut->SetAttribute(SystemTable->ConOut,
            EFI_TEXT_ATTR(fgcolour, bgcolour));

        // Clear screen to bg color
        SystemTable->ConOut->ClearScreen(SystemTable->ConOut);

        // Prompt
        SystemTable->ConOut->OutputString(SystemTable->ConOut, u">> ");

        // Wait until keypress, then return
        EFI_INPUT_KEY key;
        while (SystemTable->ConIn->ReadKeyStroke(SystemTable->ConIn, &key) != EFI_SUCCESS)
            ;

        bgcolour++;
        if (bgcolour > EFI_LIGHTGRAY)
            bgcolour = EFI_BLACK;
    }

    // Should never get here
    return EFI_SUCCESS;
}
