//
//  SGESprite.m
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGESprite.h"
#import "SGEResourcesLoader.h"
#import "SGEGLTexture.h"

@implementation SGESprite

@synthesize spriteFrame;

- (id) initFromImageFile:(NSString*)fileName
{
	if(self = [super init]){
		self.spriteFrame = [SGEResourcesLoader loadImageFile:fileName];
		
		if(self.spriteFrame.texture.highDefinition){
			
			self.contentSize = CGSizeMake(spriteFrame.frame.size.width * 0.5f,
										  spriteFrame.frame.size.height * 0.5f);
		} else {
			
			self.contentSize = spriteFrame.frame.size;
		}
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
		
		if(self.spriteFrame.texture.highDefinition){
			
			self.contentSize = CGSizeMake(spriteFrame.frame.size.width * 0.5f,
										  spriteFrame.frame.size.height * 0.5f);
		} else {
			
			self.contentSize = spriteFrame.frame.size;
		}
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

- (void) draw
{
	SGEGLTexture *texture = self.spriteFrame.texture;
	
	float k = texture.highDefinition ? 0.5f : 1.0f;
	
	CGPoint pPos = self.parent.globalPosition;
	CGPoint sPos = self.position;
	CGPoint anchor = self.anchorPointInPoints;
	GLfloat width = self.contentSize.width * k;
	GLfloat height = self.contentSize.height * k;
	
	GLfloat fWidth = self.spriteFrame.textureSpaceFrame.size.width;
	GLfloat fHeight = self.spriteFrame.textureSpaceFrame.size.height;
	GLfloat fx = self.spriteFrame.textureSpaceFrame.origin.x;
	GLfloat fy = self.spriteFrame.textureSpaceFrame.origin.y;
	
	//Texture is directed upside-down.
	//So invert coordinates too.
	GLfloat		texCoordinates[] = {
		fx, fy + fHeight,
		fx + fWidth, fy + fWidth,
		fx, fy,
		fx + fWidth, fy
	};
	
	GLfloat left = -1 * anchor.x;
	GLfloat right = width - anchor.x;
	GLfloat top = anchor.y;
	GLfloat bottom = -(height - anchor.y);
	
	GLfloat vertices[] = {
		left, bottom, 0,
		right, bottom, 0,
		left, top, 0,
		right, top, 0
	};
	
	glColor4f(self.color.red,
			  self.color.green,
			  self.color.blue,
			  self.color.alpha);
	
	glBindTexture(GL_TEXTURE_2D, texture.name);
	glVertexPointer(3, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texCoordinates);
	
	glPushMatrix();
	
	glTranslatef(pPos.x, pPos.y, 0);
	glRotatef(self.parent.rotation, 0, 0, 1);
	
	glPushMatrix();
	glTranslatef(sPos.x + anchor.x, sPos.y - anchor.y, 0);
	glRotatef(self.rotation - self.spriteFrame.rotation, 0, 0, 1);
	glScalef(self.scaleX, self.scaleY, 1);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glPopMatrix();
	
	glPopMatrix();
}

- (void) dealloc
{
	self.spriteFrame = nil;
	
	[super dealloc];
}

@end
