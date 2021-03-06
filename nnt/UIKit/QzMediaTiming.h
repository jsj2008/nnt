
# ifndef __NNT_UIKIT_QZ_MEDIATIMING_7CD04C6FA1C24D9990200E5F958B83AC_H_INCLUDED
# define __NNT_UIKIT_QZ_MEDIATIMING_7CD04C6FA1C24D9990200E5F958B83AC_H_INCLUDED

# import <QuartzCore/CAMediaTiming.h>

NNT_BEGIN_HEADER_OBJC

NNT_END_HEADER_OBJC

# ifdef NNT_CXX

NNT_BEGIN_HEADER_CXX
NNT_BEGIN_NS(qz)

template <typename implT>
class MediaTiming
: public ntl::uml::implementation<implT>
{
    typedef ntl::uml::implementation<implT> super;
    
public:
    
    void set_duration(ns::TimeInterval const& tm)
    {
        CAAnimation* obj = super::_impl();
        obj.duration = tm;
    }
    
    ns::TimeInterval duration() const
    {
        CAAnimation* obj = super::_impl();
        return obj.duration;
    }
    
    void set_speed(float val)
    {
        CAAnimation* obj = super::_impl();
        obj.speed = val;
    }
    
    float speed() const
    {
        CAAnimation* obj = super::_impl();
        return obj.speed;
    }

    void set_timeoffset(ns::TimeInterval const& tm)
    {
        CAAnimation* obj = super::_impl();
        obj.timeOffset = tm;
    }
    
    ns::TimeInterval timeoffset() const
    {
        CAAnimation* obj = super::_impl();
        return obj.timeOffset;
    }
    
    void set_repeat(float val)
    {
        CAAnimation* obj = super::_impl();
        obj.repeatCount = val;
    }
    
    float repeat() const
    {
        CAAnimation* obj = super::_impl();
        return obj.repeatCount;
    }
    
    void set_repeat_duration(ns::TimeInterval const& tm)
    {
        CAAnimation* obj = super::_impl();
        obj.repeatDuration = tm;
    }
    
    ns::TimeInterval repeat_duration() const
    {
        CAAnimation* obj = super::_impl();
        return obj.repeatDuration;
    }
    
    void set_autoreverse(bool val)
    {
        CAAnimation* obj = super::_impl();
        obj.autoreverses = val;
    }
    
    bool autoreverse() const
    {
        CAAnimation* obj = super::_impl();
        return obj.autoreverses;
    }
    
    void set_fill(ns::String const& mode)
    {
        CAAnimation* obj = super::_impl();
        obj.fillMode = mode;
    }
    
    ns::String fillmode() const
    {
        CAAnimation* obj = super::_impl();
        return obj.fillMode;
    }
    
};

NNT_END_NS
NNT_END_HEADER_CXX

# endif

# endif
