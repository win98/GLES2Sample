//
//  GameObject.m
//  GLES2Sample
//
//  Created by Sergey on 16.03.14.
//
//

#import "GameObject.h"


@implementation GameObject

@synthesize body;

- (void) update:(float)dt
{
	b2Body *b = (b2Body*)self.body;
	
	CGSize s = [SGEGameController sharedController].scene.contentSize;
	float x = b->GetPosition().x * 32;
	float y = b->GetPosition().y * 32;
	self.center = mp(x, s.height - y);
//	self.rotation = SGE_RAD_TO_DEGREES(b->GetAngle());
}

@end
