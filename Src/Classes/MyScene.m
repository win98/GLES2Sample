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

@implementation MyScene

SGESprite *s1;

- (void) prepare
{	
	SGEGLTextureAtlas *atlas = [[SGEResourcesLoader loadTextureAtlas:@"testAtlas.png"]retain];
	
	s1 = [SGESprite spriteWithSprite:@"ball.png" atlas:atlas];
	
	
	s1.center = CGPointMake(0, 300.);
	s1.anchorPoint = CGPointMake(0.5f, 0.5f);
//	s1.position = CGPointMake(100, 100);

	
	[self addChild:s1];
	
}

- (void) update:(NSTimeInterval)dt
{ static NSTimeInterval t;
	t+=dt;
	s1.position = CGPointMake(ceilf(100*t), s1.position.y);
//	s1.rotation += 40 * dt;
}

@end
