//
//  MyScene.m
//  GLES2Sample
//
//  Created by Sergey Lapochkin on 10.03.14.
//
//

#import "MyScene.h"
#import "SGEResourcesLoader.h"

@implementation MyScene

- (void) prepare
{	
	SGEGLTextureAtlas *atlas = [SGEResourcesLoader loadTextureAtlas:@"testAtlas.png"];
	NSLog(@"%@",self);
}

@end
