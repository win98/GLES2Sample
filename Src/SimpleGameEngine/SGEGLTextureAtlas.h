//
//  SGEGLTextureAtlas.h
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEGLTexture.h"
#import "SGESpriteFrame.h"
#import "SGEGameController.h"

@interface SGEGLTextureAtlas : SGEGLTexture

@property(nonatomic, retain) NSDictionary *spriteFrames;

- (id) initWithImage:(UIImage *)uiImage;

- (SGESpriteFrame*)spriteFrameNamed:(NSString*)name;

- (NSArray*)spriteFramesForNames:(NSArray*)names;

@end
