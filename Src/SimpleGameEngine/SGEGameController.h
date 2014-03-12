//
//  SGEGameController.h
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGEObject.h"
#import "SGEGLViewController.h"
#import "SGEScene.h"

@interface SGEGameController : SGEObject
{	
	BOOL isAnimating;
	
	BOOL isRetina;
	float scale;
	
	NSTimeInterval prevTime;
	
	NSTimeInterval averageDeltaTime;
}

@property(nonatomic, retain) SGEGLViewController *viewController;
@property(nonatomic) int screenFrameInterval;
@property(nonatomic, retain) SGEScene *scene;
@property(nonatomic, readonly) NSTimeInterval sceneProcessingTime;
@property(nonatomic, readonly) NSTimeInterval sceneDrawingTime;

+ (SGEGameController*) sharedController;

+ (void) setGameSceneClass:(Class)class;

+ (CGSize)screenSize;

- (CGSize)gameSceneSize;
- (BOOL) isRetina;
- (float) scale;

- (void) start;
- (void) stop;

@end
