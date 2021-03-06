
# import "Core.h"
# import "UITheme.h"
# include "uictypes.h"
# import "Bdb+NNT.h"
# import "Configuration+NNT.h"
# import "UIObject+NNT.h"

NNT_BEGIN_OBJC

# ifdef NNT_TARGET_IOS

@implementation NSObject (UITheme)

- (UIColor*)asColor {
    if ([self isKindOfClass:[NgColor class]]) {
        return [UIColor colorWithCGColor:((NgColor*)self).cgColor];
    }
    return nil;
}

- (UIImage*)asImage {
    if ([self isKindOfClass:[NgImage class]]) {
        return [UIImage imageWithCGImage:((NgImage*)self).image];
    }
    return nil;
}

@end

NNTIMPL_CATEGORY(NSObject, UITheme);

# endif

@interface UIThemePrivate : NSObject {    
    DBMSNoSqlUrlAbstract* store;
    UITheme *d_owner;
}

@property (nonatomic, assign) UITheme *d_owner;
@property (nonatomic, retain) DBMSNoSqlUrlAbstract* store;

@end

@implementation UIThemePrivate

@synthesize d_owner;
@synthesize store;

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    zero_release(store);
    [super dealloc];
}

@end

UITheme* currentTheme = nil;

@implementation UITheme

- (id)init {
    self = [super init];
    NNTDECL_PRIVATE_INIT_EX(UITheme, d_ptr_theme);
    return self;
}

- (void)dealloc {
    NNTDECL_PRIVATE_DEALLOC_EX(d_ptr_theme);
    [super dealloc];
}

+ (NSString*)themeExtension {
    return @"theme";
}

- (NSString*)themeName {
    return ((NNTBdb*)d_ptr_theme.store).name;
}

- (BOOL)loadTheme:(NSString *)name {
    return [self loadTheme:name type:NNTDirectoryTypeBundle];
}

- (BOOL)loadTheme:(NSString *)name type:(NNTDirectoryType)type {
    if (d_ptr_theme.store) {
        d_ptr_theme.store = nil;
    }
    
    NNTBdb* store = [[NNTBdb alloc] init];
    
# ifdef NNT_TARGET_IOS
#   ifdef NNT_DEVICE
    (store).readonly = YES;
#   endif
# endif
    
# ifndef NNT_DEBUG
    (store).readonly = YES;
# endif   
    
    BOOL suc = [store openDbWith:name type:type];
    if (suc == NO) {
        trace_fmt(@"theme: failed to load theme[%@].", name);
    } else {
        d_ptr_theme.store = store;
        trace_fmt(@"theme: load [%@] successful.", name);
    }
    
    safe_release(store);
    return suc;
}

- (id)instanceObject:(char const*)key {
    return [self instanceObject:(void*)key klen:(uint)strlen(key)];
}

- (id)instanceObjectByString:(NSString *)key {
    NSData* da = [key dataUsingEncoding:NSUTF8StringEncoding];
    return [self instanceObject:(void*)[da bytes] klen:(uint)[da length]];
}

- (id)instanceObject:(void *)key klen:(uint)len {
    void* data_addr;
    uint dlen;
    if ([d_ptr_theme.store get:key klen:len pdata:&data_addr pdlen:&dlen]) {
        NSData* data = [NSData dataWithBytes:data_addr length:dlen];
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        free(data_addr);
        return obj;
    }
    return nil;
}

- (NSData*)dataForKey:(void*)key klen:(uint)len {
    void* data_addr;
    uint dlen;
    if ([d_ptr_theme.store get:key klen:len pdata:&data_addr pdlen:&dlen]) {
        NSData* data = [NSData dataWithBytes:data_addr length:dlen];
        free(data_addr);
        return data;
    }
    return nil;
}

- (NSData*)dataForKey:(char const*)key {
    return [self dataForKey:(void*)key klen:(uint)strlen(key)];
}

- (NSData*)dataForValue:(NSString*)key {
    NSData* da = [key dataUsingEncoding:NSUTF8StringEncoding];
    return [self dataForKey:(void*)[da bytes] klen:(uint)[da length]];
}

- (void)removeKey:(char const*)key {
    [self removeKey:(void*)key klen:(uint)strlen(key)];
}

- (void)removeValue:(NSString*)key {
    NSData* da = [key dataUsingEncoding:NSUTF8StringEncoding];
    [self removeKey:(void*)[da bytes] klen:(uint)[da length]];
}

- (void)removeKey:(void*)key klen:(uint)len {
    [d_ptr_theme.store remove:key klen:len];
}

- (void)storeObject:(char const*)key data:(void*)data dlen:(uint)dlen {
    return [self storeObject:(void*)key klen:(uint)strlen(key) data:data dlen:dlen];
}

- (void)storeObject:(void *)key klen:(uint)klen data:(void *)data dlen:(uint)dlen {
    [d_ptr_theme.store over_raw:data dlen:dlen key:key klen:klen];
}

- (void)storeObjectString:(NSString*)key data:(void*)data dlen:(uint)dlen {
    NSData* da = [key dataUsingEncoding:NSUTF8StringEncoding];
    [self storeObject:(void*)[da bytes] klen:(uint)[da length] data:data dlen:dlen];
}

- (void)storeObject:(const char *)key obj:(id)obj {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [self storeObject:key data:(void*)[data bytes] dlen:(uint)[data length]];
}

- (void)storeObjectString:(NSString*)key obj:(id)obj {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [self storeObjectString:key data:(void*)[data bytes] dlen:(uint)[data length]];    
}

- (void)flush {
    [d_ptr_theme.store sync];
}

- (void)walk:(UIThemeWalkFunc)func {
    void* iter = [d_ptr_theme.store iterator_begin];
    for (; iter; iter = [d_ptr_theme.store iterator_next:iter]) {
        void *key, *data;
        uint klen, dlen;
        [d_ptr_theme.store iterator_retrive:iter key:&key klen:&klen data:&data dlen:&dlen];
        NSData* archive = [NSData dataWithBytes:data length:dlen];
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
        if (false == (*func)((char const*)key, klen, obj))
            break;
    }
    [d_ptr_theme.store iterator_end:iter];
}

- (NSArray*)allKeys {
    ::nnt::ns::MutableArray arr;
    void* iter = [d_ptr_theme.store iterator_begin];
    for (; iter; iter = [d_ptr_theme.store iterator_next:iter]) {
        void *key, *data;
        uint klen, dlen;
        [d_ptr_theme.store iterator_retrive:iter key:&key klen:&klen data:&data dlen:&dlen];
        if (key) {
            NSString* name = [[NSString alloc] initWithBytes:key length:klen encoding:NSUTF8StringEncoding];
            if (name)
                arr << name;
# ifdef NNT_DEBUG
            else
                trace_msg(name);
# endif
        }
    }
    return arr.consign();
}

@end

void LoadTheme(NSString* name) {
    NSString* theme_name = name;
    if (theme_name == nil)
        theme_name = [[NNTConfiguration shared] get:@"theme::selected"];
    if (theme_name == nil) {
        theme_name = [NSString stringWithFormat:@"default.%@", [UITheme themeExtension]];
    }
    UITheme *theme = [[UITheme alloc] init];
    if ([theme loadTheme:theme_name]) {
        SelectTheme(theme);
    }    

//# ifndef NNTUI_NO_THEME
//# ifdef NNT_DEBUG
//    AppDebugThemeInit(theme);
//# endif
//# endif
    
    safe_release(theme);
}

void SelectTheme(UITheme* theme) {
    NNTUIObject* ui_obj = [NNTUIObject shared];
    
    [ui_obj storeSet:@"theme::selected" obj:theme];
    currentTheme = theme;
    
    // store for next time.
    [[NNTConfiguration shared] set:@"theme::selected" val:theme.themeName];
    
    // emit signal.
    [ui_obj emit:kSignalThemeChanged result:currentTheme];
}

/*
# if defined(NNT_FRAMEWORK) && defined(NNT_DEBUG)

void AppDebugThemeInit(UITheme* theme)
{
    PASS;
}

# endif
 */

NNT_END_OBJC