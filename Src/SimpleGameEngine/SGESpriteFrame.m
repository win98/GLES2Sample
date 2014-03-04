//
//  SGESpriteFrame.m
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGESpriteFrame.h"

@implementation SGESpriteFrame

@synthesize name;
@synthesize frame;
@synthesize rotation;
@synthesize texture;
@synthesize textureSpaceFrame;

- (id) initWithTexture:(SGEGLTexture*)texture_ frame:(CGRect)frame_ rotation:(float)rotation_ name:(NSString*)name_
{
	if(self = [super init]){
		self.texture = texture_;
		self.frame = frame_;
		self.rotation = rotation_;
		self.name = name_;
	}
	
	return self;
}

+ (id) spriteWithTexture:(SGEGLTexture*)texture frame:(CGRect)frame rotation:(float)rotation name:(NSString*)name
{
	return [[[SGESpriteFrame alloc] initWithTexture:texture frame:frame rotation:rotation name:name]autorelease];
}

- (void) setFrame:(CGRect)frame_
{
	frame = frame_;
	textureSpaceFrame = CGRectMake(self.frame.origin.x / self.texture.pixelsWide,
										self.frame.origin.y / self.texture.pixelsHigh,
										self.frame.size.width / self.texture.pixelsWide,
										self.frame.size.height / self.texture.pixelsHigh);
}

- (void) dealloc
{
	self.texture = nil;
	self.name = nil;
	
	[super dealloc];
}

@end
