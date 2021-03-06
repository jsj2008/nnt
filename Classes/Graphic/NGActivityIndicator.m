
# import "Core.h"
# import "NGActivityIndicator.h"
# import "NGBase.h"

NNT_BEGIN_OBJC

@interface NgActivityIndicator ()

- (void)__init;

@end

@implementation NgActivityIndicator

@synthesize startAngle, endAngle, offsetAngle;
@synthesize ringWidth;
@synthesize ringColor;

- (void)__init {
    
    startAngle = 0;
    endAngle = 0;
    offsetAngle = -M_PI_2;
    
# ifdef NNT_TARGET_IOS
    ringWidth = NNT_ISPAD ? 8 : 3;
# else
    ringWidth = 16;
# endif
    
    //self.needsDisplayOnBoundsChange = NO;
    
    self.ringColor = [NgColor whiteColor];
}

- (id)init {
    self = [super init];
    [self __init];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self __init];
    return self;
}

- (id)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    [self __init];
    return self;
}

- (void)dealloc {
    zero_release(ringColor);

    [super dealloc];
}

- (void)setFrame:(CGRect)frame {
    // auto adjust width.
    real max = MAX(frame.size.width, frame.size.height);
    if (max * .1f < ringWidth) {
        ringWidth = max * .1f;
        if (ringWidth < 2)
            ringWidth = 2;
    }
    
    // call.
    [super setFrame:frame];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    
    CGRect rc_client = self.bounds;
    CGPoint pt_center = CGRectCenterPoint(&rc_client);
    
    real radius_out = MIN(rc_client.size.width, rc_client.size.height) * .5f;
    real radius_in = radius_out - ringWidth;
        
    CGContextSetFillColorWithColor(ctx, ringColor.cgColor);
    
    CGMutablePathRef fill_path = CGPathCreateMutable();
    
    // add out
    CGPathAddArc(fill_path, nil, pt_center.x, pt_center.y, radius_out, startAngle + offsetAngle, endAngle + offsetAngle, false);
    
    // add in
    CGPathAddArc(fill_path, nil, pt_center.x, pt_center.y, radius_in, endAngle + offsetAngle, startAngle + offsetAngle, true);
    
    // fill path
    CGContextAddPath(ctx, fill_path);
    
    CGPathRelease(fill_path);
    
    CGContextFillPath(ctx);
    
    CGContextRestoreGState(ctx);
}

@end

NNT_END_OBJC