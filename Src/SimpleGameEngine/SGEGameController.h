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
	
	NSTimeInterval prevTime;
}

@property(nonatomic, retain) SGEGLViewController *viewController;
@property(nonatomic) int screenFrameInterval;
@property(nonatomic, retain) SGEScene *scene;

+ (SGEGameController*) sharedController;
- (void) start;
- (void) stop;

@end
