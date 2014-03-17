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

#define POINTSPERMETER 32.0f

@interface MyScene()
{
	SGELayer *mainLayer;
	SGESprite *back;
	GameObject *tire, *tire2;
	
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
	gravity.x = 0;
	gravity.y = 0;
	world =  new b2World(gravity);
	
	back = [SGESprite spriteFromImageFile:@"level.png"];
	
	[self parseLevel:@"level" toWorld:world];
//	tire = [GameObject spriteFromImageFile:@"Tire.png"];
//	tire2 = [GameObject spriteFromImageFile:@"Tire.png"];
//	
//	float x = 200, y = 200, scale = 0.5f;
//	b2BodyDef wheelBodyDef;
//	wheelBodyDef.type = b2_dynamicBody;
//	wheelBodyDef.position.Set(x / POINTSPERMETER, y / POINTSPERMETER);
//	b2Body *wheelBody = world->CreateBody(&wheelBodyDef);
//	
//	b2CircleShape circle;
//	circle.m_radius = tire.contentSize.width * scale * 0.5f / POINTSPERMETER;
//	
//	b2FixtureDef wheelShapeDef;
//	wheelShapeDef.shape = &circle;
//	wheelShapeDef.density = 1.0f;
//	wheelShapeDef.friction = 0.2f;
//	wheelShapeDef.restitution = 0.7f;
//	wheelBody->CreateFixture(&wheelShapeDef);
//	
//	tire.body = wheelBody;
//
//	b2BodyDef wheelBodyDef2;
//	wheelBodyDef2.type = b2_dynamicBody;
//	wheelBodyDef2.position.Set(x / POINTSPERMETER, y / POINTSPERMETER);
//	b2Body *wheelBody2 = world->CreateBody(&wheelBodyDef);
//	
//	b2CircleShape circle2;
//	circle2.m_radius = tire.contentSize.width * scale * 0.5f / POINTSPERMETER;
//	
//	b2FixtureDef wheelShapeDef2;
//	wheelShapeDef2.shape = &circle;
//	wheelShapeDef2.density = 1.0f;
//	wheelShapeDef2.friction = 0.2f;
//	wheelShapeDef2.restitution = 0.7f;
//	wheelBody2->CreateFixture(&wheelShapeDef2);
//	
//	tire2.body = wheelBody2;
//	
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
	
	mainLayer = [[[SGELayer alloc]init] autorelease];
	mainLayer.contentSize = back.contentSize;
	
//	SGECamera *cam = [SGECamera cameraWithOwner:mainLayer];
//	cam.positionOnScene = mp(self.contentSize.width * 0.5f,
//							 self.contentSize.height * 0.5f);
//	cam.positionOnOwner = mp(mainLayer.contentSize.width * 0.5f,
//							 mainLayer.contentSize.height * 0.5f);
//	mainLayer.camera = cam;
	[mainLayer addChild:back];
	
	[self addChild:mainLayer];
	
	
	tire = [GameObject spriteFromImageFile:@"Tire.png"];
	float x = 80, y = 240, scale = 0.05f;
	b2BodyDef wheelBodyDef;
	wheelBodyDef.type = b2_dynamicBody;
	wheelBodyDef.position.Set(x / POINTSPERMETER, (640-y) / POINTSPERMETER);
	b2Body *wheelBody = world->CreateBody(&wheelBodyDef);
	
	b2CircleShape circle;
	circle.m_radius = tire.contentSize.width * scale * 0.5f / POINTSPERMETER;
	
	b2FixtureDef wheelShapeDef;
	wheelShapeDef.shape = &circle;
	wheelShapeDef.density = 1.0f;
	wheelShapeDef.friction = 0.2f;
	wheelShapeDef.restitution = 0.0f;
	wheelBody->CreateFixture(&wheelShapeDef);
	
	tire.body = wheelBody;
	tire.anchorPoint = mp(0.5, 0.5);
	tire.scale = scale;
	
	[mainLayer addChild:tire];
//	[mainLayer addChild:tire2];
	
	[self useAccelerometer:YES];


}

- (void) update:(NSTimeInterval)dt
{
	b2Vec2 gravity;
	gravity.x = -accelerationY * 9.5f * 5;
	gravity.y = accelerationX * 9.5f * 5;
	world->SetGravity(gravity);
	
	world->Step(dt, 8, 3);
	
	dx = 0;
	dy = 0;
}

- (CGPoint) pointFromString:(NSString*)string
{
	NSArray *arr = [string componentsSeparatedByCharactersInSet:
					[NSCharacterSet characterSetWithCharactersInString:@",{}"]];
	
	CGPoint vertex = mp(((NSString*)arr[1]).floatValue,
						((NSString*)arr[2]).floatValue);
	
	return vertex;
}

- (void) parseLevel:(NSString*)levelName toWorld:(b2World*)w
{
	NSString *path = [[NSBundle mainBundle]pathForResource:levelName ofType:@"plist"];
	
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
	
	if(plist){
		
		NSDictionary *staticBodies = plist[@"staticBodies"];
		
		for(NSString *key in staticBodies.allKeys){
			
			NSArray *vertices = (NSArray*)staticBodies[key];
			
			b2Vec2 *chainVertices = (b2Vec2*)calloc(vertices.count, sizeof(b2Vec2));
			
			for (int i = 0; i < vertices.count; i++) {
				CGPoint p = [self pointFromString:vertices[i]];
				chainVertices[i].Set(p.x / POINTSPERMETER, (640 - p.y) / POINTSPERMETER);
			}
			
			
//			int k = vertices.count / 8;
//			
//			for(int i = 0; i < k; i ++){
//				
//				b2ChainShape chain;
//				chain.CreateChain(&chainVertices[i * 8], 8);
//				
//				b2BodyDef bodyDef;
//				bodyDef.type = b2_staticBody;
//				b2Body *body = w->CreateBody(&bodyDef);
//				
//				b2FixtureDef shapeDef;
//				shapeDef.shape = &chain;
//				shapeDef.density = 1.0f;
//				shapeDef.friction = 0.2f;
//				shapeDef.restitution = 0.0f;
//				body->CreateFixture(&shapeDef);
//			}
			
//			k = vertices.count % 8;
			
//			if(k){
				b2ChainShape chain;
				chain.CreateLoop(chainVertices, vertices.count);
				
				b2BodyDef bodyDef;
				bodyDef.type = b2_staticBody;
				b2Body *body = w->CreateBody(&bodyDef);
				
				b2FixtureDef shapeDef;
				shapeDef.shape = &chain;
				shapeDef.density = 1.0f;
				shapeDef.friction = 0.2f;
				shapeDef.restitution = 0.0f;
				body->CreateFixture(&shapeDef);
//			}
			
			free(chainVertices);
		}
	}
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
