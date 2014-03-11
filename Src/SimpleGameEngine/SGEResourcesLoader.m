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
	
	UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
	NSAssert(img, @"Image not found:", name);
	
	if(img){
		
		SGEGLTexture *texture = [[[SGEGLTexture alloc]initWithImage:img]autorelease];
		
		texture.textureFileName = [NSString stringWithFormat:@"%@.png", name];
		
		if([name hasSuffix:@"-hd"] || [name hasSuffix:@"-HD"]){
			texture.highDefinition = YES;
		}
		
		CGRect frame = CGRectMake(0, 0,
								  texture.contentSize.width, texture.contentSize.height);
		
		sFrame = [SGESpriteFrame spriteWithFrame:frame texture:texture rotation:0 name:texture.textureFileName];
	}
	
	return sFrame;
}

+ (SGESpriteFrame*) spriteFrameFromDictionary:(NSDictionary*)dic name:(NSString*)name texture:(SGEGLTexture*)tex
{
	SGESpriteFrame *sFrame = nil;
	
	CGRect frame;
	CGPoint offset;
	BOOL rotated;
	CGRect sourceColorRect;
	CGSize sourceSize;
	
	NSString *str = dic[@"frame"];
	NSArray *arr = [str componentsSeparatedByCharactersInSet:
							[NSCharacterSet characterSetWithCharactersInString:@",{}"]];
	//
	frame = CGRectMake(((NSString*)arr[2]).floatValue,
					   ((NSString*)arr[3]).floatValue,
					   ((NSString*)arr[6]).floatValue,
					   ((NSString*)arr[7]).floatValue);
				
	str = dic[@"offset"];
	arr = [str componentsSeparatedByCharactersInSet:
					[NSCharacterSet characterSetWithCharactersInString:@",{}"]];
	//
	offset = CGPointMake(((NSString*)arr[1]).floatValue,
						 ((NSString*)arr[2]).floatValue);
	
	str = dic[@"rotated"];
	//
	rotated = str.boolValue;
	
	str = dic[@"sourceColorRect"];
	arr = [str componentsSeparatedByCharactersInSet:
					[NSCharacterSet characterSetWithCharactersInString:@",{}"]];
	//
	sourceColorRect = CGRectMake(((NSString*)arr[2]).floatValue,
								 ((NSString*)arr[3]).floatValue,
								 ((NSString*)arr[6]).floatValue,
								 ((NSString*)arr[7]).floatValue);
	
	str = dic[@"sourceSize"];
	arr = [str componentsSeparatedByCharactersInSet:
		   [NSCharacterSet characterSetWithCharactersInString:@",{}"]];
	//
	sourceSize = CGSizeMake(((NSString*)arr[2]).floatValue,
							((NSString*)arr[2]).floatValue);
	
	float angle = rotated ? -90 : 0;
	
	//TODO: make sprites to work with offset
	
	sFrame = [SGESpriteFrame spriteWithFrame:frame texture:tex	rotation:angle name:name];
	
	return sFrame;
}

+ (SGEGLTextureAtlas*) loadTextureAtlas:(NSString*)fileName
{
	SGEGLTextureAtlas *atlas = nil;
	
	NSString *name = [fileName lastPathComponent];
	name = (NSString*)[[name componentsSeparatedByString:@"."]firstObject];
	
	UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
	NSAssert(img, @"Image not found:", name);
	
	if(img){
		
		atlas = [[[SGEGLTextureAtlas alloc]initWithImage:img]autorelease];
		
		if([name hasSuffix:@"-hd"] || [name hasSuffix:@"-HD"]){
			atlas.highDefinition = YES;
		}
	}
	
	NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"plist"];
	
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
	NSAssert(plist, @"Incorrect plist format:", name);
	
	if(plist){
		
		NSDictionary *frames = plist[@"frames"];
		
		NSMutableDictionary *dic = [NSMutableDictionary dictionary];
		
		for(NSString *key in frames.allKeys){
			
			SGESpriteFrame *sFrame = [self spriteFrameFromDictionary:[frames objectForKey:key]
																name:[NSString stringWithString:key]
									  texture:atlas];
			
			[dic setObject:sFrame forKey:[NSString stringWithString:key]];
		}
		
		atlas.spriteFrames = dic;
		atlas.textureFileName = plist[@"metadata"][@"textureFileName"];
	}
	
	return atlas;
}

@end
