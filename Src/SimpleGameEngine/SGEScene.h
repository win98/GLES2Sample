//
//  SGEScene.h
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGENode.h"
#import "SGEGLView.h"

@interface SGEScene : SGENode<TouchesDelegateProtocol>
{
	EAGLContext *context;

	int km_mat4_default_context_ref;
	
	GLint sceneWidth;
	GLint sceneHeight;

	float accelerationX;
	float accelerationY;
	float accelerationZ;
	
	GLuint framebuffer, renderbuffer;
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
- (void) drawContent;
- (void) useAccelerometer:(BOOL)use;

@end
