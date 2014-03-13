//
//  SGEAnimation.h
//  GLES2Sample
//
//  Created by Sergey Lapochkin on 13.03.14.
//
//

#import "SGEScene.h"
#import "SGEGameController.h"

@class SGESprite, SGESpriteFrame;

@interface SGEFramesSequence : SGEObject

@property(nonatomic, retain) NSArray *frames;
@property(nonatomic) int currentFrameNum;

- (int) totalFrames;
- (void) nextFrame;
- (void) prevFrame;
- (SGESpriteFrame*) currentframe;
- (BOOL)isLastFrame;
- (void) reset;

@end

@interface SGEAnimation : SGEObject<GameEventsProtocol>
{
	//return to original frame after animation fully finished
	BOOL returnToStart;
	NSTimer *timer;
	SEL finishCallback;
}

@property(nonatomic) BOOL looped;
@property(nonatomic) float framesInterval;

- (id) initWithFrames:(NSArray*)frames framesInterval:(float)interval animationObject:(SGESprite*)object
			   looped:(BOOL)loop returnToFirstFrame:(BOOL)ret startImmediatelly:(BOOL)start
	 onFinishCallback:(SEL)finSel;

+ (id) animationWithFrames:(NSArray*)frames framesInterval:(float)interval animationObject:(SGESprite*)object
					looped:(BOOL)loop returnToFirstFrame:(BOOL)ret startImmediatelly:(BOOL)start
		  onFinishCallback:(SEL)finSel;

+ (id) infiniteAnimationWithFrames:(NSArray*)frames framesInterval:(float)interval
				   animationObject:(SGESprite*)object;

+ (id) animationWithFrames:(NSArray*)frames framesInterval:(float)interval
		   animationObject:(SGESprite*)object onFinishCallback:(SEL)callback;

- (void) start;

- (void) reset;

- (void) pause;

- (void) stop;

- (void) switchToOriginalFrameAndStop;

@end
