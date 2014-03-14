//
//  SGELayer.m
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGELayer.h"
#import "SGEGameController.h"

@implementation SGECamera

@synthesize positionOnOwner;
@synthesize positionOnScene;
@synthesize owner;

- (id) initWithOwner:(SGENode*)owner_
{
	if(self = [super init]){
		
		owner = owner_;
	}
	
	return self;
}

+ (id) cameraWithOwner:(SGENode*)owner_
{
	return [[[SGECamera alloc]initWithOwner:owner_] autorelease];
}

- (void) setPositionOnOwner:(CGPoint)positionOnOwner_
{
	CGSize ss = [[SGEGameController sharedController] gameSceneSize];
	
	CGPoint cps = positionOnScene;
	CGPoint cpo = positionOnOwner_;
	
	float x = cps.x - cpo.x;
	float y = cps.y - cpo.y;
	
	if(x > 0){
		x = 0;
		positionOnOwner_.x = cps.x;
	}
	if(y > 0){
		y = 0;
		positionOnOwner_.y = cps.y;
	}
	if(x < ss.width - self.owner.contentSize.width){
		
		x = ss.width - self.owner.contentSize.width;
		positionOnOwner_.x = -x + cps.x;
	}
	if(y < ss.height - self.owner.contentSize.height){
		
		y = ss.height - self.owner.contentSize.height;
		positionOnOwner_.y = -y + cps.y;
	}
	
	positionOnOwner = positionOnOwner_;
	
	self.owner.position = mp(x, y);
}

@end

@implementation SGELayer

@synthesize camera;

- (void) setCamera:(SGECamera *)camera_
{
	[camera release];
	camera = [camera_ retain];
	
	camera.owner = self;
	
	//update
	camera.positionOnOwner = camera.positionOnOwner;
}

- (void) dealloc
{
	self.camera = nil;
	
	[super dealloc];
}

@end
