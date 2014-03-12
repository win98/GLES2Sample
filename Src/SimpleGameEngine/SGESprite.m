//
//  SGESprite.m
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGESprite.h"
#import "SGEResourcesLoader.h"
#import "SGEGameController.h"

@implementation SGESprite

@synthesize spriteFrame;
@synthesize texture;

- (id) initFromImageFile:(NSString*)fileName
{
	if(self = [super init]){
		
		self.spriteFrame = [SGEResourcesLoader loadImageFile:fileName];
		
		self.texture = self.spriteFrame.texture;
	}
	
	return self;
}

- (id) initFromImageFile:(NSString*)fileName position:(CGPoint)pos
{
	if(self = [self initFromImageFile:fileName]){
		
		self.position = pos;
	}
	
	return self;
}

- (id) initWithSpriteFrame:(SGESpriteFrame*)sFrame
{
	if(self = [super init]){
		
		self.spriteFrame = sFrame;
		
		self.texture = self.spriteFrame.texture;
	}
	
	return self;
}

- (id) initWithSpriteFrame:(SGESpriteFrame*)sFrame position:(CGPoint)pos
{
	if(self = [self initWithSpriteFrame:sFrame]){
		
		self.position = pos;
	}
	
	return self;
}

- (id) initWithName:(NSString*)sprite atlas:(SGEGLTextureAtlas*)atlas
{	if(self = [super init]){
		
		self.spriteFrame = atlas.spriteFrames[sprite];
		
		self.texture = self.spriteFrame.texture;
	}
	
	return self;
}

+ (id) spriteFromImageFile:(NSString*)fileName
{
	return [[[SGESprite alloc]initFromImageFile:fileName]autorelease];
}

+ (id) spriteFromImageFile:(NSString*)fileName position:(CGPoint)pos
{
	return [[[SGESprite alloc]initFromImageFile:fileName position:pos]autorelease];
}

+ (id) spriteWithSpriteFrame:(SGESpriteFrame*)sFrame
{
	return [[[SGESprite alloc]initWithSpriteFrame:sFrame]autorelease];
}

+ (id) spriteWithSpriteFrame:(SGESpriteFrame*)sFrame position:(CGPoint)pos
{
	return [[[SGESprite alloc]initWithSpriteFrame:sFrame position:pos]autorelease];
}

+ (id) spriteWithName:(NSString*)sprite atlas:(SGEGLTextureAtlas*)atlas
{
	return [[[SGESprite alloc] initWithName:sprite atlas:atlas] autorelease];
}

- (void) setSpriteFrame:(SGESpriteFrame *)spriteFrame_
{
	[spriteFrame release];
	spriteFrame = [spriteFrame_ retain];
	
	if(!spriteFrame){
		return;
	}
	
	self.texture = self.spriteFrame.texture;
	
	BOOL isRetina = [[SGEGameController sharedController] isRetina];
	
	float sizeFactor = 1.0f;
	
	if(isRetina){
		
		
		if(self.texture.highDefinition){
			sizeFactor = 1.0f;
		} else {
			sizeFactor = 2.0f;
		}
	} else {
		
		if(self.texture.highDefinition){
			sizeFactor = 0.5f;
		} else {
			sizeFactor = 1.0f;
		}
	}
	
	self.contentSize = CGSizeMake(spriteFrame.frame.size.width * sizeFactor,
								  spriteFrame.frame.size.height * sizeFactor);
	
	needToUpdatetransform = YES;
}

- (void) draw
{
	kmMat4 mvMatrix;
	
	kmGLGetMatrix(KM_GL_MODELVIEW, &mvMatrix);
	glLoadMatrixf(mvMatrix.mat);
	
	glColor4f(self.color.red,
			  self.color.green,
			  self.color.blue,
			  self.color.alpha);
	
	[self.spriteFrame.texture drawFrame:self.spriteFrame.textureSpaceFrame
							inRectWithSize:self.contentSize
						withAnchorPoint:self.anchorPointInPoints];
}

- (void) dealloc
{
	self.spriteFrame = nil;
	self.texture = nil;
	
	[super dealloc];
}

@end
