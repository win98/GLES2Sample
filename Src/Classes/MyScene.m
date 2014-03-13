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
#import "SGEAnimation.h"

@implementation MyScene

SGESprite *s1, *s2, *s3, *s4, *s5, *back, *back2;
int play = 0;

float prevx;
float dx = 0;

SGEAnimation *anim;

//TODO  -(+)Animation class
//		-Layers
//		-Camera
//		-Font(!)
//		-Buttons(!)

- (void) prepare
{	
	SGEGLTextureAtlas *atlas = [[SGEResourcesLoader loadTextureAtlas:@"oceanSingletons-hd.png"]retain];
	
	back = [SGESprite spriteFromImageFile:@"back1.png"];
	back2 = [SGESprite spriteFromImageFile:@"back1.png"];
	
	s1 = [SGESprite spriteWithName:@"osingleton1.png" atlas:atlas];
	s2 = [SGESprite spriteWithName:@"osingleton2.png" atlas:atlas];
	s3 = [SGESprite spriteWithName:@"osingleton3.png" atlas:atlas];
	s4 = [SGESprite spriteWithName:@"osingleton4.png" atlas:atlas];
	s5 = [SGESprite spriteWithName:@"osingleton5.png" atlas:atlas];
	
	[self addChild:back];
	[self addChild:back2];
	back.position = mp(-back.contentSize.width, 0);
	[self addChild:s1];
	s1.anchorPoint = mp(0.2f, 0.5f);

	NSArray *names = @[@"osingleton1.png", @"osingleton2.png",
					   @"osingleton3.png", @"osingleton4.png", @"osingleton5.png"];
	
	anim = [[SGEAnimation alloc] initWithFrames:[atlas spriteFramesForNames:names]
								 framesInterval:0.1f animationObject:s1 looped:NO returnToFirstFrame:YES startImmediatelly:YES onFinishCallback:nil];

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
	
	s1.rotation += 45 * dt;
	
	if(s1.rotation >= 360){
		[anim switchToOriginalFrameAndStop];
		[anim release];
		anim = nil;
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
