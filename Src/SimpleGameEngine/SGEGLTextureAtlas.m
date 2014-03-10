//
//  SGEGLTextureAtlas.m
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEGLTextureAtlas.h"

@implementation SGEGLTextureAtlas

@synthesize spriteFrames;

- (id) initWithImage:(UIImage *)uiImage
{
	if(self = [super initWithImage:uiImage]){
		
	}
	
	return self;
}

- (void) dealloc
{
	self.spriteFrames = nil;
	
	[super dealloc];
}

@end
