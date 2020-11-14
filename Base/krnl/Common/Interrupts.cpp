#include "Interrupts.h"

namespace bOS::Kernel {

    void Interrupts::Interrupts_Disable() 
    {
        
    }

    void Interrupts::Interrupts_Enable()
    {
       
    }

    void Interrupts::Interrupts_Enable(bool sysp)
    {
        Interrupts_Enable();
        if (sysp)
        {
            for (;;)
            {
                hlt();
            }
        }
    }


    void Interrupts::Interrupts_Enabled() {}
}