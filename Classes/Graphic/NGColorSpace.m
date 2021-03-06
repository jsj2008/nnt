
# import "Core.h"
# import "NGColorSpace.h"

NNT_BEGIN_OBJC

/**	@cond */
@interface NgColorSpace ()

@property (nonatomic, readwrite, assign) CGColorSpaceRef cgColorSpace;

@end
/**	@endcond */

/** @brief Wrapper around CGColorSpaceRef
 *
 *  A wrapper class around CGColorSpaceRef
 *
 * @todo More documentation needed 
 **/

@implementation NgColorSpace

/** @property cgColorSpace. 
 *  @brief The CGColorSpace to wrap around 
 **/
@synthesize cgColorSpace;

#pragma mark -
#pragma mark Class methods

/** @brief Returns a shared instance of CGColorSpace initialized with the standard RGB space
 *
 * For the iPhone this is CGColorSpaceCreateDeviceRGB(), for Mac OS X CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB).
 *
 *  @return A shared CGColorSpace object initialized with the standard RGB colorspace.
 **/
+(NgColorSpace *)genericRGBSpace { 
	static NgColorSpace *space = nil;
	if (nil == space) { 
        CGColorSpaceRef cgSpace = NULL; 
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
		cgSpace = CGColorSpaceCreateDeviceRGB();
#else
		cgSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB); 
#endif
        space = [[NgColorSpace alloc] initWithCGColorSpace:cgSpace];
		CGColorSpaceRelease(cgSpace);
	} 
	return space; 
} 

#pragma mark -
#pragma mark Init/Dealloc

/** @brief Initializes a newly allocated colorspace object with the specified color space.
 *  This is the designated initializer.
 *
 *	@param colorSpace The color space.
 *  @return The initialized CGColorSpace object.
 **/
-(id)initWithCGColorSpace:(CGColorSpaceRef)colorSpace {
    self = [super init];
    if ( self ) {
        CGColorSpaceRetain(colorSpace);
        cgColorSpace = colorSpace;
    }
    return self;
}

-(void)dealloc {
    CGColorSpaceRelease(cgColorSpace);
    [super dealloc];
}

-(void)finalize {
    CGColorSpaceRelease(cgColorSpace);
	[super finalize];
}

#pragma mark -
#pragma mark Accessors

-(void)setCGColorSpace:(CGColorSpaceRef)newSpace {
    if ( newSpace != cgColorSpace ) {
        CGColorSpaceRelease(cgColorSpace);
        CGColorSpaceRetain(newSpace);
        cgColorSpace = newSpace;
    }
}

@end


NNT_END_OBJC