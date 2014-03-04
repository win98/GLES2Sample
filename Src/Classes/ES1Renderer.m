/*
 
 File: ES1Renderer.m
 
 Abstract: The ES1Renderer class creates an OpenGL ES 1.1 context and draws 
 using OpenGL ES 1.1 functions.
 
 Version: 1.0
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
*/

#import "ES1Renderer.h"
#import "SGESprite.h"

#define DEGREES_TO_RADIANS(__ANGLE) ((__ANGLE) / 180.0 * M_PI)

@implementation ES1Renderer
NSMutableArray *sprites;
int k = 50;
SGESprite *s1, *s2;
// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }
		
		srandom(time(0));
		
		SGEGLTexture *texture = [[[SGEGLTexture alloc]initWithImage:
								  [UIImage imageNamed:@"atlas.png"]]autorelease];
		SGESpriteFrame *sFrame = [[SGESpriteFrame alloc]initWithTexture:texture
																  frame: CGRectMake(92, 92, 92, 92)
															   rotation:0 name:@""];
		s1 = [[SGESprite alloc]initWithSpriteFrame:sFrame];
		s1.position = CGPointMake(0, 0);// + s1.contentSize.height);
		s1.anchorPoint = CGPointMake(0.5f, 0.5f);
		s1.rotation = 45;
		
		s2 = [[SGESprite alloc]initFromImageFile:@"box2.png"];
		s2.position = CGPointMake(100, 400);
		s2.rotation = 45;
		[s2 addChild:s1];
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
	}
	
	return self;
}

- (void) setRenderFrameSize:(CGSize)size
{
	backingHeight = size.height;
	backingWidth = size.width;
}

- (void) setupDrawing
{
	static dispatch_once_t once;
	
	dispatch_once(&once, ^{
		
		glEnable(GL_DEPTH_TEST);
		
		glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
		glEnable(GL_TEXTURE_2D);
		
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glEnable(GL_BLEND);
		
		glShadeModel(GL_SMOOTH);
		
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrthof(0, backingWidth, 0, backingHeight, -1, 1);
		glViewport(0, 0, backingWidth, backingHeight);
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		
		glClearColor(1, 0, 0, 1);
    });
	
    
}

- (void) render {

    [self setupDrawing];
	
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glColor4f(1, 1, 1, 1);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
//	[s1 process];
	[s2 process];
	s2.rotation -= 2;
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
//	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
//  glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

- (void) dealloc
{
	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}
	
	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}

@end
