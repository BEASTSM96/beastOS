
#define MAGIC_CHECK_NUM 0x2BADB002
#define CHAR_NUM 0xb8000

void dmain(void* mbd, unsigned int magic) {
    if (magic != MAGIC_CHECK_NUM)
    {
        _print_("Error!: magic != 0x2BADB002!", 0x04);
    }
    else
    {
        _print_("Hello form C!", 0x07);
    }
}

void _print_(char* msg, int color) 
{
    char* mem = (char*)(CHAR_NUM);
    while (*msg != 0)
    {
        *mem = *msg;
        mem++;
        msg++;
        *mem = (char*)color;
        mem++;
    }
    
}