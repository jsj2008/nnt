
# import "Core.h"
# import "QzDisplayLink.h"

NNT_BEGIN_OBJC

signal_t kSignalDisplayLink = @"::nnt::ui::displaylink::got";

@implementation UIDisplayLink

@synthesize displayLink = _ca;

- (id)init {
    self = [super init];
    
    _ca = [[CADisplayLink displayLinkWithTarget:self selector:@selector(_cb_displaylink)] retain];
    
    return self;
}

- (void)dealloc {
    safe_release(_ca);
    
    [super dealloc];
}

NNTEVENT_BEGIN
NNTEVENT_SIGNAL(kSignalDisplayLink)
NNTEVENT_END

- (void)_cb_displaylink {
    [self emit:kSignalDisplayLink];
}

- (void)hook {

}

- (void)unhook {
    [_ca invalidate];
}

@end

NNT_END_OBJC
