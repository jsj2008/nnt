
# import "Core.h"
# import "Console+NNT.h"
# import "Directory+NNT.h"

NNT_BEGIN_OBJC

signal_t kSignalPrint = @"::nnt::console::print";

# define CON ((::nnt::Console*)h_console)

static NNTConsole* __gs_console = nil;

@implementation NNTConsole

- (id)init {
    self = [super init];
    
    h_console = new ::nnt::Console;
    
    return self;
}

- (void)dealloc {
    delete (::nnt::Console*) h_console;
    h_console = NULL;
    [super dealloc];
}

NNTEVENT_BEGIN
NNTEVENT_SIGNAL(kSignalPrint)
NNTEVENT_END

- (void)print:(NSString*)str {
    [self emit:kSignalPrint result:str];
    
    CON->print(str.UTF8String);
}

- (void)println:(NSString*)str {
    [self emit:kSignalPrint result:str];
    
    CON->println(str.UTF8String);
}

+ (NNTConsole*)shared {
    NNT_SYNCHRONIZED(self)
    
    if (__gs_console == nil) {
        __gs_console = [[self alloc] init];
    }
    
    NNT_SYNCHRONIZED_END
    
    return __gs_console;
}

@end

NNT_END_OBJC

NNT_BEGIN_CXX

Console::Console()
{
    _hout = stdout;
    _hin = stdin;
    _herr = stderr;
    
    _hdup = false;
    _nln = true;
}

Console::~Console()
{
    if (_hdup & b00000001)
    {
        fclose(_hout);
    }
    if (_hdup & b00000010)
    {
        fclose(_hin);
    }
    if (_hdup & b00000100)
    {
        fclose(_herr);
    }
}

char const* Console::prefix = "nnt";
char const* Console::suffix = "$ ";

void Console::print(const char * str) const
{
    if (str)
        fwrite(str, 1, strlen(str), _hout);
}

void Console::println(const char * str) const
{
    if (str)
        fwrite(str, 1, strlen(str), _hout);
    fwrite("\r\n", 1, 2, _hout);
    
    if (!_nln)
        _nln = true;
}

void* Console::watcher_input(void *arg)
{
    return NULL;
}

NNT_END_CXX