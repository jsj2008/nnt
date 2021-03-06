
# ifndef __NNT_Ng_IMAGEFILTER_21BF8A8D521B42F6A7D2059248ADAC69_H_INCLUDED
# define __NNT_Ng_IMAGEFILTER_21BF8A8D521B42F6A7D2059248ADAC69_H_INCLUDED

# import "NGImage.h"

NNT_BEGIN_HEADER_OBJC

@protocol NgImageFilter <NSObject>

- (NgImage*)apply:(NgImage*)image;

@end

@interface NgImageFilter : NNTObject < NgImageFilter >

@end

NNTDECL_OBJCXX_WRAPPER(NgImageFilter);

NNT_END_HEADER_OBJC

# ifdef NNT_CXX

NNT_BEGIN_HEADER_CXX
NNT_BEGIN_NS(cg)

class IImageFilter
: public ns::cxx::IObject
{
public:
    
    virtual cg::Image apply(cg::Image const&) const = 0;
    
};

class ImageFilter
: public ns::cxx::Object<NNT_OBJCXX_WRAPPER(NgImageFilter), IImageFilter>
{
public:
    
    ImageFilter()
    {
        PASS;
    }
    
    virtual cg::Image apply(cg::Image const&) const
    {
        return cg::Image::Null();
    }
    
};

NNT_BEGIN_NS(filter)

class SetColor
: public ImageFilter
{
public:
    
    virtual cg::Image apply(cg::Image const&) const;
    
    Color color;
    
};

class OverColor
: public ImageFilter
{
public:
    
    virtual cg::Image apply(cg::Image const&) const;
    
    Color color;
    
};

NNT_END_NS

NNT_END_NS
NNT_END_HEADER_CXX

# endif

# endif
