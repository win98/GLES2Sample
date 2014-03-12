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
@synthesize texture;
@synthesize spriteData;

- (id) initWithData:(SGEPlistData)data texture:(SGEGLTexture*)texture_ name:(NSString*)name_
{
	if(self = [super init]){
		self.spriteData = data;
		texture = texture_;
		self.name = name_;
	}
	
	return self;
}

+ (id) spriteFrameWithData:(SGEPlistData)data texture:(SGEGLTexture*)texture_ name:(NSString*)name_
{
	return [[[SGESpriteFrame alloc] initWithData:data texture:texture_ name:(NSString*)name_]autorelease];
}

- (void) dealloc
{
	self.name = nil;
	
	[super dealloc];
}

@end
