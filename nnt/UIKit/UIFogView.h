
# ifndef __NNT_UIKIT_UIFOGVIEW_13A8E82ED5C24481B076E3949A7F561E_H_INCLUDED
# define __NNT_UIKIT_UIFOGVIEW_13A8E82ED5C24481B076E3949A7F561E_H_INCLUDED

# import "UIView+NNT.h"

NNT_BEGIN_HEADER_OBJC

NNTDECL_EXTERN_CLASS(NgGradient);

@interface UIFogView : NNTUIView {
    
    NgGradient *fogColor;
    real fogDepth;
    
}

@property (nonatomic, retain) NgGradient *fogColor;
@property (nonatomic) real fogDepth;

@end

NNT_END_HEADER_OBJC

# endif