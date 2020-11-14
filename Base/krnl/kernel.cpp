#include "kernel.h"
#include "Common/Base_defs.h"
#include "Common/VGA.h"
#include "Common/Interrupts.h"

namespace bOS::Kernel
{
    #if defined(__linux__) 
    #error "You are not using a cross-compiler"
    #endif
    
    #if !defined(__i386__)
    #error "This needs to be compiled with a ix86-elf compiler"
    #endif

    Terminal::Terminal() {}
    Terminal::~Terminal() {}

    void Terminal::Terminal_Initialize() {
        terminal_row = 0;
        terminal_column = 0;
        terminal_color = VGA::Entry_color(VGA::Color::LIGHT_GREY, VGA::Color::BLACK);
        terminal_buffer = (uint16_t*) 0xB8000;
        for (size_t y = 0; y < 25; y++) {
            for (size_t x = 0; x < 80; x++) {
                const size_t index = y * 80 + x;
                terminal_buffer[index] = VGA::Entry(' ', terminal_color);
            }
        }
    }

    size_t strlen(const char* str) 
    {
        size_t len = 0;
        while (str[len])
            len++;
        return len;
    }
    
    void Terminal::Terminal_Setcolor(uint8_t color) 
    {
        terminal_color = color;
    }
    
    void Terminal::Terminal_Putentryat(char c, uint8_t color, size_t x, size_t y) 
    {
        const size_t index = y * 80 + x;
        terminal_buffer[index] = VGA::Entry(c, color);
    }

    void Terminal::Terminal_Putchar(char c) 
    {
        Terminal_Putentryat(c, terminal_color, terminal_column, terminal_row);
        if (++terminal_column == 80) {
            terminal_column = 0;
            if (++terminal_row == 25)
                terminal_row = 0;
        }
        if (c == '\n'){
            terminal_row++;
            terminal_column = 0;
           // terminal_color = 0;
        }
    }

    void Terminal::Terminal_Write(const char* data, size_t size) 
    {
        for (size_t i = 0; i < size; i++)
            Terminal_Putchar(data[i]);
    }
    
    void Terminal::Terminal_WriteString(const char* data) 
    {
        Terminal_Write(data, strlen(data));
    }

    extern "C" {
    void kernel_main(void)
    {
        //should we maybe use a static void for the run?
        //TODO: ^
        bOS::Kernel::Kernel krnl = bOS::Kernel::Kernel();

        Terminal GLB_LOGGER = Terminal();
        GLB_LOGGER.Terminal_Initialize();
        GLB_LOGGER.Terminal_WriteString("[ NO CHECK OK ] Loading from kernel_main");

        krnl.Run();
    }
    }

    void Kernel::Run()
    {
        Terminal Kernel_Loader_Terminal = Terminal();
        Kernel_Loader_Terminal.Terminal_Initialize();
        Kernel_Loader_Terminal.Terminal_Setcolor(VGA::Color::GREEN);

        Kernel_Loader_Terminal.Terminal_WriteString("Loading...");
        Kernel_Loader_Terminal.Terminal_WriteString("\n\n");
        

        ///////////////////////////////
        // ------> START INTERRUPTS //
        /////////////////////////////
        Interrupts::Interrupts_Enable();
    }
}