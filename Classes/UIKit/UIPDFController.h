
# ifndef __NNT_UIKIT_UIPDFCONTROLLER_20621E40DC2846608EAA8E15838E9F4A_H_INCLUDED
# define __NNT_UIKIT_UIPDFCONTROLLER_20621E40DC2846608EAA8E15838E9F4A_H_INCLUDED

# import "UIViewController+NNT.h"

NNT_BEGIN_HEADER_OBJC

NNTDECL_PRIVATE_HEAD(UIPDFController);

@interface UIPDFController : NNTUIViewController {
    
    NNTDECL_PRIVATE(UIPDFController);
}

- (id)initWithURL:(NSURL*)url;

@end

NNT_END_HEADER_OBJC

# endif