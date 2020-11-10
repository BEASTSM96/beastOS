#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "Common/Base_defs.h"

namespace bOS::Kernel {

    class Terminal
    {
    public:
        Terminal();
        //TODO: maybe add somewhat of a way to save the log?)
        ~Terminal();

        void Terminal_Initialize();
        void Terminal_Setcolor(uint8_t color);
        void Terminal_Putentryat(char c, uint8_t color, size_t x, size_t y);
        void Terminal_Putchar(char c);
        void Terminal_Write(const char* data, size_t size);
        void Terminal_WriteString(const char* data);

        size_t terminal_row;
        size_t terminal_column;
        uint8_t terminal_color;
        uint16_t* terminal_buffer;
    };

    class Kernel {
    public:
        void Run();
        void kernel_main(void);
    public:
        static const size_t VGA_WIDTH = 80;
        static const size_t VGA_HEIGHT = 25;
    };
}