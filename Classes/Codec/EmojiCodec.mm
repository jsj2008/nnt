
# import "Core.h"
# import "EmojiCodec.h"

# ifdef NNT_TARGET_IOS
# import "UIDevice+NNT.h"
# endif

NNT_BEGIN_CXX
NNT_BEGIN_NS(sys)

EmojiVersion::EmojiVersion()
{
# ifdef NNT_TARGET_IOS
    VERSION_SOFTBANK = [[UIDevice currentDevice].systemVersion doubleValue] < 5.0;
# else
    VERSION_SOFTBANK = false;
# endif
    
    if (VERSION_SOFTBANK == false)
    {
        CHAR_IDR = '\xf0';
    }
}

bool EmojiVersion::VERSION_SOFTBANK = false;
char EmojiVersion::CHAR_IDR = '\xee';

bool EmojiConverter::read_emoji(core::string::const_iterator& iter, core::string& res)
{
    if (*iter != EmojiVersion::CHAR_IDR)
        return false;
    
    if (EmojiVersion::VERSION_SOFTBANK)
    {
        char uni[4] = {0};
        
        uni[0] = EmojiVersion::CHAR_IDR;
        uni[1] = *(++iter);
        uni[2] = *(++iter);
        
        res = core::string(uni);
    }
    else
    {
        char uni[5] = {0};
        
        uni[0] = EmojiVersion::CHAR_IDR;
        uni[1] = *(++iter);
        uni[2] = *(++iter);
        uni[3] = *(++iter);
        
        res = core::string(uni);
    }
    
    return true;
}

NNT_END_NS
NNT_END_CXX
