//
//  SGEResourcesLoader.h
//  GLES2Sample
//
//  Created by Sergey on 02.03.14.
//
//

#import <UIKit/UIKit.h>
#import "SGESpriteFrame.h"
#import "SGEGLTextureAtlas.h"

@interface SGEResourcesLoader : UIImage

+ (SGESpriteFrame*) loadImageFile:(NSString*)fileName;
+ (SGEGLTextureAtlas*) loadTextureAtlas:(NSString*)fileName;

@end
