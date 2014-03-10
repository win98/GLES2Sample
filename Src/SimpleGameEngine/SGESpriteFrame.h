//
//  SGESpriteFrame.h
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEObject.h"
#import "SGEGLTexture.h"

@interface SGESpriteFrame : SGEObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic) CGRect frame;
@property(nonatomic) float rotation;
@property(nonatomic, assign) SGEGLTexture *texture;
@property(nonatomic, readonly) CGRect textureSpaceFrame;

- (id) initWithTexture:(SGEGLTexture*)texture frame:(CGRect)frame rotation:(float)rotation name:(NSString*)name;

+ (id) spriteWithTexture:(SGEGLTexture*)texture frame:(CGRect)frame rotation:(float)rotation name:(NSString*)name;

@end
