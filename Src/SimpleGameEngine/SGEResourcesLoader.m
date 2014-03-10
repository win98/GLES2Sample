//
//  SGEResourcesLoader.m
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEResourcesLoader.h"
#import "SGEGLTexture.h"

@implementation SGEResourcesLoader

+ (SGESpriteFrame*) loadImageFile:(NSString*)fileName
{
	SGESpriteFrame *sFrame = nil;
	
	NSString *name = [fileName lastPathComponent];
	name = (NSString*)[[name componentsSeparatedByString:@"."]firstObject];
	
	UIImage *img = [UIImage imageNamed:fileName];
	if(img){
		
		SGEGLTexture *texture = [[[SGEGLTexture alloc]initWithImage:img]autorelease];
		
		if([name hasSuffix:@"@2x"]){
			texture.highDefinition = YES;
		}
		
		CGRect frame = CGRectMake(0, 0,
								  texture.contentSize.width, texture.contentSize.height);
		
		sFrame = [SGESpriteFrame spriteWithTexture:texture frame:frame rotation:0 name:name];
	}
	
	return sFrame;
}

@end
