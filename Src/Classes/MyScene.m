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

SGESprite *s1, *s2;

- (void) prepare
{	
	SGEGLTextureAtlas *atlas = [[SGEResourcesLoader loadTextureAtlas:@"testAtlas.png"]retain];
	
//	s1 = [SGESprite spriteWithName:@"box.png" atlas:atlas];
	s1 = [SGESprite spriteFromImageFile:@"apple_ex-hd.png"];
	s2 = [SGESprite spriteFromImageFile:@"apple_ex.png"];
	
	s1.center = CGPointMake(300.5, 300);
	s1.anchorPoint = CGPointMake(0.5f, 0.5f);
	s1.position = CGPointMake(100, 100);

	
	[self addChild:s1];
	[self addChild:s2];
	
}

- (void) update:(NSTimeInterval)dt
{ static NSTimeInterval t;
	t+=dt;
//	if (t >= 40) t = 40;
	s1.position = CGPointMake(100, 0);
	s2.position = CGPointMake(450, 0);
//	s1.rotation += 40 * dt;
}

@end
