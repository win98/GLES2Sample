//
//  SGESpriteFrame.h
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEObject.h"
#import "SGEGLTexture.h"

typedef struct _plistData{
	CGRect frame;
	CGPoint offset;
	BOOL rotated;
	CGRect sourceColorRect;
	CGSize sourceSize;
}plistData;

@interface SGESpriteFrame : SGEObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic) CGRect frame;
@property(nonatomic) float rotation;
@property(nonatomic, assign) SGEGLTexture *texture;
@property(nonatomic, readonly) CGRect textureSpaceFrame;
@property(nonatomic) plistData spriteData;

- (id) initWithTexture:(SGEGLTexture*)texture frame:(CGRect)frame rotation:(float)rotation name:(NSString*)name;

+ (id) spriteWithFrame:(CGRect)frame texture:(SGEGLTexture*)texture rotation:(float)rotation name:(NSString*)name;

@end
