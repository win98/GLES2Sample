//
//  SGESprite.h
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGENode.h"
#import "SGEGLTexture.h"
#import "SGESpriteFrame.h"

@interface SGESprite : SGENode

@property(nonatomic, retain) SGESpriteFrame *spriteFrame;

//One image - one texture
- (id) initFromImageFile:(NSString*)fileName;
- (id) initFromImageFile:(NSString*)fileName position:(CGPoint)pos;

+ (id) spriteFromImageFile:(NSString*)fileName;
+ (id) spriteFromImageFile:(NSString*)fileName position:(CGPoint)pos;


//Image from texture atlas
- (id) initWithSpriteFrame:(SGESpriteFrame*)sFrame;
- (id) initWithSpriteFrame:(SGESpriteFrame*)sFrame position:(CGPoint)pos;

+ (id) spriteWithSpriteFrame:(SGESpriteFrame*)sFrame;
+ (id) spriteWithSpriteFrame:(SGESpriteFrame*)sFrame position:(CGPoint)pos;

@end
