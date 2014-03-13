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

- (NSArray*)spriteFramesForNames:(NSArray*)names
{
	NSMutableArray *arr = [NSMutableArray array];
	
	for(NSString *n in names){
		SGESpriteFrame *f = [self spriteFrameNamed:n];
		NSAssert(f, @"No such spriteframe:%@ in texture atlas: %@", n, self.textureFileName);
		[arr addObject:f];
	}
	
	return arr;
}

- (SGESpriteFrame*) spriteFrameNamed:(NSString *)name
{
	SGESpriteFrame *result;
	
	NSString *n = (NSString*)[[name componentsSeparatedByString:@"."]firstObject];
	if([n hasSuffix:@"-hd"] || [n hasSuffix:@"-HD"]){
		n = [n stringByReplacingCharactersInRange:NSMakeRange(n.length-3, 3)
											 withString:@""];
	}
	
	if([[SGEGameController sharedController] isRetina]){
		
		//Try to get -hd for Retina screen. If not - try to get sd
		result = self.spriteFrames[[NSString stringWithFormat:@"%@-hd.png", n]];
		
		if(!result){
			result = self.spriteFrames[[NSString stringWithFormat:@"%@.png", n]];
		}
	} else {
		
		//Try to get sd for non-retina screen. If not - try to get hd
		result = self.spriteFrames[[NSString stringWithFormat:@"%@.png", n]];
		if(!result){
			result = self.spriteFrames[[NSString stringWithFormat:@"%@-hd.png", n]];
		}
	}
	
	return result;
}

- (void) dealloc
{
	self.spriteFrames = nil;
	
	[super dealloc];
}

@end
