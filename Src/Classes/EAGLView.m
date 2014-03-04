/*
 
 File: EAGLView.m
 
 Abstract: The EAGLView class is a UIView subclass that renders OpenGL scene.
 If the current hardware supports OpenGL ES 2.0, it draws using OpenGL ES 2.0;
 otherwise it draws using OpenGL ES 1.1.
 
 Version: 1.0
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
*/

#import "EAGLView.h"

@implementation EAGLView

@synthesize animating;
@synthesize animationFrameInterval;

// You must implement this method
+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id) initWithFrame:(CGRect)frame
{    
    if ((self = [super initWithFrame:frame])){
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		renderer = [[ES1Renderer alloc] init];
		[renderer setRenderFrameSize:frame.size];
        
		animating = FALSE;
		animationFrameInterval = 1;
		displayLink = nil;
		self.multipleTouchEnabled = NO;
    }
	
    return self;
}

- (void) drawView:(id)sender
{
	NSTimeInterval t1 = [NSDate timeIntervalSinceReferenceDate];
	
    [renderer render];
	
	NSTimeInterval t2 = [NSDate timeIntervalSinceReferenceDate];
	NSTimeInterval dt = t2-t1;
	NSLog(@"Render time: %f", dt);
}

- (void) layoutSubviews
{
	[renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
	if (!animating){
        displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView:)];
        [displayLink setFrameInterval:animationFrameInterval];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
		animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (animating){
		[displayLink invalidate];
        displayLink = nil;
		
		animating = FALSE;
	}
}

- (void) dealloc
{
    [renderer release];
	
    [super dealloc];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
