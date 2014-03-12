//
//  MyScene.m
//  GLES2Sample
//
//  Created by Sergey Lapochkin on 10.03.14.
//
//

#import "MyScene.h"
#import "SGEResourcesLoader.h"
#import "SGESprite.h"
#import "SGEGameController.h"

@implementation MyScene

SGESprite *s1, *s2, *back, *back2;

- (void) prepare
{	
	SGEGLTextureAtlas *atlas = [[SGEResourcesLoader loadTextureAtlas:@"oceanSingletons-hd.png"]retain];
	
	s1 = [SGESprite spriteWithName:@"osingleton5.png" atlas:atlas];

	[self addChild:s1];

	
}

- (void) update:(NSTimeInterval)dt
{
	
}

@end
