
# import "Core.h"
# import "UIFallFlowController.h"

NNT_BEGIN_OBJC

@implementation UIFallFlowController

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)loadView {
    UIFallFlow* fall = [[UIFallFlow alloc] initWithZero];
    self.view = fall;
    safe_release(fall);
}

@end

NNT_END_OBJC

_CXXCONTROLLER_IMPL(UIFallFlowController);
