//
//  SGESpriteFrame.h
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import "SGEObject.h"
#import "SGEGLTexture.h"

typedef struct _SGEPlistData{
	CGRect frame;
	CGPoint offset;
	BOOL rotated;
	CGRect sourceColorRect;
	CGSize sourceSize;
}SGEPlistData;

@interface SGESpriteFrame : SGEObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic, assign, readonly) SGEGLTexture *texture;
@property(nonatomic) SGEPlistData spriteData;

- (id) initWithData:(SGEPlistData)data texture:(SGEGLTexture*)texture name:(NSString*)name;
+ (id) spriteFrameWithData:(SGEPlistData)data texture:(SGEGLTexture*)texture name:(NSString*)name;

@end
