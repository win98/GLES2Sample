//
//  SGEScene.m
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGEScene.h"

@implementation SGEScene

- (id) init
{
	if(self = [super init]){
		
		self.position = CGPointMake(0, 0);
		
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		if (!context || ![EAGLContext setCurrentContext:context] )
        {
            [self release];
            return nil;
        }
		
		kmGLSetCurrentContext(&km_mat4_default_context_ref);
		kmGLMatrixMode(KM_GL_MODELVIEW);
		kmGLLoadIdentity();
		kmGLTranslatef(0, sceneHeight, 0);
		
		srandom(time(0));		
		
		glGenFramebuffersOES(1, &framebuffer);
		NSAssert( framebuffer, @"Can't create frame buffer");
		glGenRenderbuffersOES(1, &renderbuffer);
		NSAssert( renderbuffer, @"Can't create render buffer");
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, framebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, renderbuffer);
		
		[self prepare];
	}
	
	return self;
}

- (void) prepare
{
	
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &sceneWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &sceneHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
	
	[self setupDrawing];
    
    return YES;
}

- (void) setupDrawing
{
	kmGLSetCurrentContext(&km_mat4_default_context_ref);
	kmGLMatrixMode(KM_GL_MODELVIEW);
	kmGLLoadIdentity();
	kmGLTranslatef(0, sceneHeight, 0);
	
	self.contentSize = CGSizeMake(sceneWidth, sceneHeight);
	
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
	glOrthof(0, sceneWidth, 0, sceneHeight, -1, 1);
	glViewport(0, 0, sceneWidth, sceneHeight);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	glClearColor(0, 0, 0, 0);
}

- (void) drawContent
{
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, framebuffer);
	
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	glColor4f(1, 1, 1, 1);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	[self process];
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void) dealloc
{
	if (framebuffer)
	{
		glDeleteFramebuffersOES(1, &framebuffer);
		framebuffer = 0;
	}
	
	if (renderbuffer)
	{
		glDeleteRenderbuffersOES(1, &renderbuffer);
		renderbuffer = 0;
	}
	
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

@end
