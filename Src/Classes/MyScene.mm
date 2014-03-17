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
#import "SGELayer.h"
#import "Box2D.h"
#import "GameObject.h"

#define POINTSPERMETER 64.0f

@interface MyScene()
{
	SGELayer *mainLayer;
	SGESprite *back;
	GameObject *tire;
	
	float dx, dy;
		
	b2World *world;
}

@end

@implementation MyScene

//TODO  -(+)Animation class
//		-(+)Layers
//		-(+)Camera
//		-Font(!)
//		-Buttons(!)

- (void) prepare
{
	b2Vec2 gravity;
	gravity.x = -2;
	gravity.y = -9.8;
	world =  new b2World(gravity);
	
	back = [SGESprite spriteFromImageFile:@"back1.png"];
	tire = [GameObject spriteFromImageFile:@"Tire.png"];
	
	float x = 200, y = 200, scale = 0.5f;
	b2BodyDef wheelBodyDef;
	wheelBodyDef.type = b2_dynamicBody;
	wheelBodyDef.position.Set(x / POINTSPERMETER, y / POINTSPERMETER);
	b2Body *wheelBody = world->CreateBody(&wheelBodyDef);
	
	b2CircleShape circle;
	circle.m_radius = tire.contentSize.width * scale * 0.5f / POINTSPERMETER;
	
	b2FixtureDef wheelShapeDef;
	wheelShapeDef.shape = &circle;
	wheelShapeDef.density = 1.0f;
	wheelShapeDef.friction = 0.2f;
	wheelShapeDef.restitution = 0.7f;
	wheelBody->CreateFixture(&wheelShapeDef);
	
	tire.body = wheelBody;

	float worldWidth = self.contentSize.width / POINTSPERMETER;
	float worldHeight = self.contentSize.height / POINTSPERMETER;
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0,0);
	b2Body *groundBody = world->CreateBody(&groundBodyDef);
	b2EdgeShape boundsShape;
	b2FixtureDef boundsFixture;
	boundsFixture.shape = &boundsShape;
	boundsShape.Set(b2Vec2(0,0), b2Vec2(worldWidth, 0));
	groundBody->CreateFixture(&boundsFixture);
	boundsShape.Set(b2Vec2(worldWidth, 0), b2Vec2(worldWidth, worldHeight));
	groundBody->CreateFixture(&boundsFixture);
	boundsShape.Set(b2Vec2(worldWidth, worldHeight), b2Vec2(0, worldHeight));
	groundBody->CreateFixture(&boundsFixture);
	boundsShape.Set(b2Vec2(0, worldHeight), b2Vec2(0, 0));
	groundBody->CreateFixture(&boundsFixture);
	
	world->SetAllowSleeping(false);
	
	tire.anchorPoint = mp(0.5, 0.5);
	tire.scale = scale;
	
	mainLayer = [[[SGELayer alloc]init] autorelease];
	mainLayer.contentSize = back.contentSize;
	
	SGECamera *cam = [SGECamera cameraWithOwner:mainLayer];
	cam.positionOnScene = mp(self.contentSize.width * 0.5f,
							 self.contentSize.height * 0.5f);
	cam.positionOnOwner = mp(mainLayer.contentSize.width * 0.5f,
							 mainLayer.contentSize.height * 0.5f);
	mainLayer.camera = cam;
	[mainLayer addChild:back];
	
	[self addChild:mainLayer];
	[mainLayer addChild:tire];
	
	[self useAccelerometer:YES];


}

- (void) update:(NSTimeInterval)dt
{
	b2Vec2 gravity;
	gravity.x = -accelerationY * 9.5f;
	gravity.y = accelerationX * 9.5f;
	world->SetGravity(gravity);
	
	world->Step(dt, 8, 3);
	
	dx = 0;
	dy = 0;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	float x = [((UITouch*)[touches anyObject]) locationInView:[SGEGameController sharedController].viewController.view].x;
	float prevX = [((UITouch*)[touches anyObject]) previousLocationInView:[SGEGameController sharedController].viewController.view].x;
	
	float y = [((UITouch*)[touches anyObject]) locationInView:[SGEGameController sharedController].viewController.view].y;
	float prevY = [((UITouch*)[touches anyObject]) previousLocationInView:[SGEGameController sharedController].viewController.view].y;
	
	dx = (x - prevX) * 2;
	dy = (y - prevY) * 2;
}

@end
