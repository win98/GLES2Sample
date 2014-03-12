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

SGESprite *s1, *s2, *s3, *s4, *s5, *back, *back2;
int play = 0;

float prevx;
float dx = 0;

- (void) prepare
{	
	SGEGLTextureAtlas *atlas = [[SGEResourcesLoader loadTextureAtlas:@"oceanSingletons-hd.png"]retain];
	
	back = [SGESprite spriteFromImageFile:@"back1.png"];
	back2 = [SGESprite spriteFromImageFile:@"back2.png"];
	
	s1 = [SGESprite spriteWithName:@"osingleton1.png" atlas:atlas];
	s2 = [SGESprite spriteWithName:@"osingleton2.png" atlas:atlas];
	s3 = [SGESprite spriteWithName:@"osingleton3.png" atlas:atlas];
	s4 = [SGESprite spriteWithName:@"osingleton4.png" atlas:atlas];
	s5 = [SGESprite spriteWithName:@"osingleton5.png" atlas:atlas];
	
	
	[self addChild:back];
	[self addChild:back2];
	back.position = mp(-back.contentSize.width, 0);
//	[self addChild:s1];
	s1.center = mp(self.center.x, self.center.y);
	s1.anchorPoint = mp(0.5f, 0.5f);
//	s1.scale = 0.5f;
	[s1 addChild:s2];
	[s2 addChild:s3];
	[s3 addChild:s4];
	[s4 addChild:s5];

	
}

- (void) update:(NSTimeInterval)dt
{
	back.position = mp(back.position.x + dx, 0);
	back2.position = mp(back2.position.x + dx, 0);

	if(back.position.x >= self.contentSize.width){
		back.position = mp(- back.contentSize.width, 0);
	}
	if(back2.position.x >= self.contentSize.width){
		back2.position = mp(- back2.contentSize.width, 0);
	}
	
	dx = 0;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	prevx = [((UITouch*)[touches anyObject]) locationInView:[SGEGameController sharedController].viewController.view].x;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	float x = [((UITouch*)[touches anyObject]) locationInView:[SGEGameController sharedController].viewController.view].x;
	
	dx = x - prevx;
	prevx = x;
}

@end
