//
//  SGEResourcesLoader.m
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEResourcesLoader.h"
#import "SGEGLTexture.h"
#import "SGEGameController.h"

@implementation SGEResourcesLoader

+ (SGESpriteFrame*) loadImageFile:(NSString*)fileName
{
	SGESpriteFrame *sFrame = nil;
	
	NSString *name = [fileName lastPathComponent];
	name = (NSString*)[[name componentsSeparatedByString:@"."]firstObject];
	if([name hasSuffix:@"-hd"] || [name hasSuffix:@"-HD"]){
		name = [name stringByReplacingCharactersInRange:NSMakeRange(name.length-3, 3)
											 withString:@""];
	}
	
	UIImage *img = nil;
	
	if([[SGEGameController sharedController] isRetina]){
		
		//Try to get -hd for Retina screen. If not - try to get sd
		NSString *fName = [name stringByAppendingString:@"-hd"];
		img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", fName]];
		if(img){
			name = [name stringByAppendingString:@"-hd"];
		} else {
			img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
		}
	} else {
		
		//Try to get sd for non-retina screen. If not - try to get hd
		img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
		if(!img){
			name = [name stringByAppendingString:@"-hd"];
			img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
		}
	}
	
	NSAssert(img, @"Image not found:", fileName);
	
	if(img){
		
		SGEGLTexture *texture = [[[SGEGLTexture alloc]initWithImage:img]autorelease];
		
		texture.textureFileName = [NSString stringWithFormat:@"%@.png", name];
		
		if([name hasSuffix:@"-hd"] || [name hasSuffix:@"-HD"]){
			texture.highDefinition = YES;
		}
		
		CGRect frame = CGRectMake(0, 0,
								  texture.contentSize.width, texture.contentSize.height);
		
		SGEPlistData data;
		
		data.frame = frame;
		data.offset = mp(0, 0);
		data.rotated = NO;
		data.sourceColorRect = frame;
		data.sourceSize = frame.size;
		
		sFrame = [SGESpriteFrame spriteFrameWithData:data texture:texture name:texture.textureFileName];
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
	sourceSize = CGSizeMake(((NSString*)arr[1]).floatValue,
							((NSString*)arr[2]).floatValue);
	
	SGEPlistData data;
	data.frame = frame;
	data.offset = offset;
	data.rotated = rotated;
	data.sourceColorRect = sourceColorRect;
	data.sourceSize = sourceSize;
	
	sFrame = [SGESpriteFrame spriteFrameWithData:data texture:tex name:name];
	
	return sFrame;
}

+ (SGEGLTextureAtlas*) loadTextureAtlas:(NSString*)fileName
{
	SGEGLTextureAtlas *atlas = nil;
	
	NSString *name = [fileName lastPathComponent];
	name = (NSString*)[[name componentsSeparatedByString:@"."]firstObject];
	if([name hasSuffix:@"-hd"] || [name hasSuffix:@"-HD"]){
		name = [name stringByReplacingCharactersInRange:NSMakeRange(name.length-3, 3)
											 withString:@""];
	}
	
	UIImage *img = nil;
	
	if([[SGEGameController sharedController] isRetina]){
		
		//Try to get -hd for Retina screen. If not - try to get sd
		NSString *fName = [name stringByAppendingString:@"-hd"];
		img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", fName]];
		if(img){
			name = [name stringByAppendingString:@"-hd"];
		} else {
			img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
		}
	} else {
		
		//Try to get sd for non-retina screen. If not - try to get hd
		img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
		if(!img){
			name = [name stringByAppendingString:@"-hd"];
			img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
		}
	}
	
	NSAssert(img, @"Image not found:", fileName);
	
	if(img){
		
		atlas = [[[SGEGLTextureAtlas alloc]initWithImage:img]autorelease];
		
		if([name hasSuffix:@"-hd"] || [name hasSuffix:@"-HD"]){
			atlas.highDefinition = YES;
		}
	}
	
	NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"plist"];
	
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
	NSAssert(plist, @"No plist or incorrect plist format:", name);
	
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
