
# ifndef __NNT_UIKIT_UISEGMENTEDCONTROL_B0C4964EE76341B483DFE51C1D187503_H_INCLUDED
# define __NNT_UIKIT_UISEGMENTEDCONTROL_B0C4964EE76341B483DFE51C1D187503_H_INCLUDED

NNT_BEGIN_HEADER_OBJC

@interface UISegmentedControl (NNT)

-(void)setTag:(NSInteger)tag forSegmentAtIndex:(NSUInteger)segment;
-(void)setTintColor:(UIColor*)color forTag:(NSInteger)aTag;
-(void)setTextColor:(UIColor*)color forTag:(NSInteger)aTag;
-(void)setShadowColor:(UIColor*)color forTag:(NSInteger)aTag;

@end

NNTDECL_CATEGORY(UISegmentedControl, NNT);

@interface NNTUISegmentedControl : UISegmentedControl {
    NNTOBJECT_DECL;
    
    //! default color of item.
    UIColor *defaultColor;
    
    //! color of selected item.
    UIColor *selectedColor;
    
    //! shadow of item.
    UIColor *shadowColor;
    
    //! text color for default item.
    UIColor *defaultTextColor;
    
    //! text color for selected item.
    UIColor *selectedTextColor;
    
    //! enable reselected, default is NO.
    BOOL enableReselected;

    @private
    uint __custom_tag_begin;
    NSUInteger __lst_selected;
}

NNTOBJECT_PROP;

@property (nonatomic, retain) UIColor *defaultColor, *selectedColor, *shadowColor, *defaultTextColor, *selectedTextColor;
@property (nonatomic, assign) BOOL enableReselected;

//! init with items.
- (id)initWithItems:(NSArray *)items custom:(BOOL)custom;

@end

NNT_EXTERN signal_t kSignalSelectChanged;

NNT_END_HEADER_OBJC

# ifdef NNT_CXX

# include "UIControl+NNT.h"

NNT_BEGIN_HEADER_CXX
NNT_BEGIN_NS(ui)

class SegmentedControl
: public Control<SegmentedControl, NNTUISegmentedControl>
{
    typedef Control<SegmentedControl, NNTUISegmentedControl> super;
    
public:
    
    SegmentedControl()
    {
        PASS;
    }
    
    SegmentedControl(ns::Array const& arr)
    : super(nil)
    {
        this->_self = [[NNTUISegmentedControl alloc] initWithItems:arr custom:YES];
    }
    
    void set_items(ns::Array const& arr)
    {
        UIView* super_view = nil;
        if (this->_self)
        {
            super_view = this->_self.superview;
            [this->_self removeFromSuperview];
            [this->_self release];
        }
        
        this->_self = [[NNTUISegmentedControl alloc] initWithItems:arr custom:YES];
        if (super_view)
            [super_view addSubview:this->_self];
        
        set_select(0);
    }
    
    void set_select(uint idx)
    {
        this->_self.selectedSegmentIndex = idx;
    }
    
    uint selected() const
    {
        return this->_self.selectedSegmentIndex;
    }
    
    void set_default(Color const& color)
    {
        this->_self.defaultColor = color;
    }
    
    void set_selected(Color const& color)
    {
        this->_self.selectedColor = color;
    }
    
    void set_shadow(Color const& color)
    {
        this->_self.shadowColor = color;
    }
    
    void set_text(Color const& color)
    {
        this->_self.defaultTextColor = color;
    }
    
    void set_selected_text(Color const& color)
    {
        this->_self.selectedTextColor = color;
    }
    
    void reselectable(bool val)
    {
        this->_self.enableReselected = val;
    }
    
};

NNT_END_NS
NNT_END_HEADER_CXX

# endif

# endif