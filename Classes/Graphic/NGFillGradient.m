
# import "Core.h"
# import "NGFillGradient.h"
# import "NGGradient.h"

NNT_BEGIN_OBJC

/**	@cond */
@interface NgFillGradient()

@property (nonatomic, readwrite, copy) NgGradient *_fillGradient;

@end
/**	@endcond */

/** @brief Draws NgGradient area fills.
 *
 *	Drawing methods are provided to fill rectangular areas and arbitrary drawing paths.
 **/

@implementation NgFillGradient

/** @property fillGradient
 *  @brief The fill gradient.
 **/
@synthesize _fillGradient;

#pragma mark -
#pragma mark init/dealloc

/** @brief Initializes a newly allocated _NgFillGradient object with the provided gradient.
 *  @param aGradient The gradient.
 *  @return The initialized _NgFillGradient object.
 **/
-(id)initWithGradient:(NgGradient *)aGradient 
{
    self = [super init];
	if ( self ) {
		_fillGradient = [aGradient retain];
	}
	return self;
}

-(void)dealloc
{
	[_fillGradient release];	
	[super dealloc];
}

#pragma mark -
#pragma mark Drawing

/** @brief Draws the gradient into the given graphics context inside the provided rectangle.
 *  @param theRect The rectangle to draw into.
 *  @param theContext The graphics context to draw into.
 **/
-(void)fillRect:(CGRect)theRect inContext:(CGContextRef)theContext
{
	[self._fillGradient fillRect:theRect inContext:theContext];
}

/** @brief Draws the gradient into the given graphics context clipped to the current drawing path.
 *  @param theContext The graphics context to draw into.
 **/
-(void)fillPathInContext:(CGContextRef)theContext
{
	[self._fillGradient fillPathInContext:theContext];
}

#pragma mark -
#pragma mark NSCopying methods

-(id)copyWithZone:(NSZone *)zone
{
	NgFillGradient *copy = [[[self class] allocWithZone:zone] init];
	copy->_fillGradient = [self->_fillGradient copyWithZone:zone];
    
	return copy;
}

#pragma mark -
#pragma mark NSCoding methods

-(Class)classForCoder
{
	return [NgFill class];
}

-(void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self._fillGradient forKey:@"fillGradient"];
}

-(id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
	if ( self ) {
		_fillGradient = [[coder decodeObjectForKey:@"fillGradient"] retain];
	}
	return self;
}

@end


NNT_END_OBJC