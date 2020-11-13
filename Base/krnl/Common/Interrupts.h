#include "Core.h"

namespace bOS::Kernel
{
    class Interrupts
    {
    public:
        static void Interrupts_Disable();
        static void Interrupts_Enable();
        static void Interrupts_Enabled();
    };
} // namespace bOS::Kernel
