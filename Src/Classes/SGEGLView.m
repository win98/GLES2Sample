//
//  SGEGLView.m
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGEGLView.h"
#import "SGEGameController.h"

@implementation SGEGLView

@synthesize touchesDelegate;

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

- (id) initWithFrame:(CGRect)frame
{    
    if ((self = [super initWithFrame:frame])){

        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
    }
	
    return self;
}

- (void) layoutSubviews
{
	[[SGEGameController sharedController].scene resizeFromLayer:(CAEAGLLayer*)self.layer];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.touchesDelegate touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.touchesDelegate touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.touchesDelegate touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.touchesDelegate touchesCancelled:touches withEvent:event];
}

@end
