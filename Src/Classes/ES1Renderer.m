/*
 
 File: ES1Renderer.m
 
 Abstract: The ES1Renderer class creates an OpenGL ES 1.1 context and draws 
 using OpenGL ES 1.1 functions.
 
 Version: 1.0
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
*/

#import "ES1Renderer.h"
#import "SGESprite.h"
#import "matrix.h"

@implementation ES1Renderer
NSMutableArray *sprites;
int k = 50;
SGENode *globalNode;
SGESprite *s1, *s2, *s3;


// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		
		
		SGEGLTexture *texture = [[[SGEGLTexture alloc]initWithImage:
								  [UIImage imageNamed:@"atlas.png"]]autorelease];
		SGESpriteFrame *sFrame = [[SGESpriteFrame alloc]initWithTexture:texture
																  frame: CGRectMake(92, 92, 92, 92)
															   rotation:0 name:@"pic"];
		s2 = [SGESprite spriteWithSpriteFrame:sFrame];
		
		s1 = [[SGESprite alloc]initFromImageFile:@"box2.png"];
		s1.position = CGPointMake(300, 300);
		
		SGESpriteFrame *sFrame2 = [[SGESpriteFrame alloc]initWithTexture:texture
																  frame: CGRectMake(184, 184, 92, 92)
															   rotation:0 name:@"pic"];
		s3 = [SGESprite spriteWithSpriteFrame:sFrame2];
		s3.position = CGPointMake(46, 46);
		[s1 addChild:s2];
		[s1 addChild:s3];
		s2.z = 100;
		s2.center = CGPointMake(0, 0);
		s3.z = 100;
		globalNode = [[SGENode alloc]initWithPosition:CGPointMake(0, 0)];
		globalNode.contentSize = CGSizeMake(768, 1024);
		[globalNode addChild:s1];
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		
	}
	
	return self;
}





- (void) render {

    
}





@end
