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
@synthesize vxQuad;
@synthesize txQuad;

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
	
	initialScale = sizeFactor;
	
	self.contentSize = CGSizeMake(spriteFrame.spriteData.sourceSize.width * sizeFactor,
								  spriteFrame.spriteData.sourceSize.height * sizeFactor);
	
	[self calculateQuads];
	
	needToUpdatetransform = YES;
}

- (void) setAnchorPoint:(CGPoint)anchorPoint_
{
	[super setAnchorPoint:anchorPoint_];
	
	[self calculateQuads];
}

- (void) calculateQuads
{
	SGEPlistData data = self.spriteFrame.spriteData;
	CGPoint ap = self.anchorPointInPoints;
	
	float l = - ap.x / initialScale;
	float r = data.sourceSize.width - ap.x / initialScale;
	float t = ap.y / initialScale;
	float b = - data.sourceSize.height + ap.y / initialScale;
	
	float loffset = data.sourceColorRect.origin.x;
	float roffset = data.sourceColorRect.origin.x - data.offset.x * 2.0f;
	float toffset = data.sourceColorRect.origin.y;
	float boffset = data.sourceColorRect.origin.y + data.offset.y * 2.0f;
	
	l += loffset;
	r -= roffset;
	t -= toffset;
	b += boffset;
	
	l *= initialScale;
	r *= initialScale;
	t *= initialScale;
	b *= initialScale;
	
	vxQuad.bl = mp(l, b);
	vxQuad.br = mp(r, b);
	vxQuad.tl = mp(l, t);
	vxQuad.tr = mp(r, t);
	
	
	if(data.rotated){
		l = data.frame.origin.x;
		r = data.frame.origin.x + data.frame.size.height;
		t = data.frame.origin.y;
		b = data.frame.origin.y + data.frame.size.width;
		
		l /= self.texture.pixelsWide;
		r /= self.texture.pixelsWide;
		t /= self.texture.pixelsHigh;
		b /= self.texture.pixelsHigh;
		
		txQuad.bl = mp(r, t);
		txQuad.br = mp(r, b);
		txQuad.tl = mp(l, t);
		txQuad.tr = mp(l, b);
	} else {
		l = data.frame.origin.x;
		r = data.frame.origin.x + data.frame.size.width;
		t = data.frame.origin.y + data.frame.size.height;
		b = data.frame.origin.y;
		
		l /= self.texture.pixelsWide;
		r /= self.texture.pixelsWide;
		t /= self.texture.pixelsHigh;
		b /= self.texture.pixelsHigh;
		
		txQuad.bl = mp(l, b);
		txQuad.br = mp(r, b);
		txQuad.tl = mp(l, t);
		txQuad.tr = mp(r, t);
	}
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
	
	[self.texture drawTextureQuad:self.txQuad verticesQuad:self.vxQuad];
}

- (void) dealloc
{
	self.spriteFrame = nil;
	self.texture = nil;
	
	[super dealloc];
}

@end
