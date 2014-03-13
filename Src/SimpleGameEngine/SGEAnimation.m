//
//  SGEAnimation.m
//  GLES2Sample
//
//  Created by Sergey Lapochkin on 13.03.14.
//
//

#import "SGEAnimation.h"
#import "SGESprite.h"
#import "SGESpriteFrame.h"

@implementation SGEFramesSequence

@synthesize frames;
@synthesize currentFrameNum;

- (id) initWithSpriteFrames:(NSArray*)array
{
	if(self = [super init]){
		
		self.frames = array;
		self.currentFrameNum = 0;
		isOverlapped = NO;
	}
	
	return self;
}

+ (id) sequenceWithSpriteFrames:(NSArray*)array
{
	return [[[SGEFramesSequence alloc]initWithSpriteFrames:array] autorelease];
}

- (int) totalFrames
{
	return self.frames.count;
}

- (void) nextFrame
{
	isOverlapped = NO;
	
	if(++self.currentFrameNum >= [self totalFrames]){
		
		self.currentFrameNum = 0;
		isOverlapped = YES;
	}
}

- (void) prevFrame
{
	if(--self.currentFrameNum < 0){
		self.currentFrameNum = [self totalFrames];
	}
}

- (BOOL)isOverlapped
{
	return isOverlapped;
}

- (SGESpriteFrame*) currentframe
{
	return  self.frames[self.currentFrameNum];
}

- (void) reset
{
	self.currentFrameNum = 0;
}

- (void) dealloc
{
	self.frames = nil;
	
	[super dealloc];
}

@end

@interface SGEAnimation()

@property(nonatomic, retain) SGEFramesSequence *sequence;
@property(nonatomic, retain) SGESpriteFrame *originalSpriteFrame;
@property(nonatomic, assign) SGESprite *animationObject;

@end

@implementation SGEAnimation

@synthesize looped;
@synthesize framesInterval;
@synthesize sequence;
@synthesize originalSpriteFrame;

- (id) initWithFrames:(NSArray*)frames framesInterval:(float)interval animationObject:(SGESprite*)object
			   looped:(BOOL)loop returnToFirstFrame:(BOOL)ret startImmediatelly:(BOOL)start
	 onFinishCallback:(SEL)finSel
{
	NSAssert([frames count], @"Frames count for creating animation should not be nil!");
	
	if(self = [super init]){
		
		self.sequence = [SGEFramesSequence sequenceWithSpriteFrames:frames];
		framesInterval = interval;
		self.animationObject = object;
		self.originalSpriteFrame = object.spriteFrame;
		looped = loop;
		returnToStart = ret;
		finishCallback = finSel;
		
		if(start){
			[self performSelector:@selector(start) withObject:nil afterDelay:0.0f];
		}
	}
	
	return self;
}

+ (id) animationWithFrames:(NSArray*)frames framesInterval:(float)interval animationObject:(SGESprite*)object
					looped:(BOOL)loop returnToFirstFrame:(BOOL)ret startImmediatelly:(BOOL)start
		  onFinishCallback:(SEL)finSel
{
	return [[[SGEAnimation alloc]initWithFrames:frames framesInterval:interval
								animationObject:object looped:loop returnToFirstFrame:ret startImmediatelly:start onFinishCallback:finSel] autorelease];
}

+ (id) infiniteAnimationWithFrames:(NSArray*)frames framesInterval:(float)interval
				   animationObject:(SGESprite*)object
{
	return [[[SGEAnimation alloc]initWithFrames:frames framesInterval:interval
							   animationObject:object looped:YES returnToFirstFrame:NO startImmediatelly:YES onFinishCallback:nil] autorelease];
}

+ (id) animationWithFrames:(NSArray*)frames framesInterval:(float)interval
		   animationObject:(SGESprite*)object onFinishCallback:(SEL)callback
{
	return [[[SGEAnimation alloc]initWithFrames:frames framesInterval:interval
							   animationObject:object looped:YES returnToFirstFrame:YES startImmediatelly:YES onFinishCallback:callback] autorelease];
}

- (void) switchToOriginalFrameAndStop
{
	[self.animationObject setSpriteFrame:self.originalSpriteFrame];
	
	[self.sequence reset];
	
	[self stopTimer];
}

- (void) tick
{
	if(![self.sequence isOverlapped]){
		//normal animation flow
		
		[self.animationObject setSpriteFrame:self.sequence.currentframe];
		[self.sequence nextFrame];
	} else {
		
		if(self.looped){
			//animation finished but it's in loop mode
			
			[self.animationObject setSpriteFrame:self.sequence.currentframe];
			[self.sequence nextFrame];
		} else {
			//animation is fully finished
			
			if(finishCallback && [self.animationObject respondsToSelector:finishCallback]){
				[self.animationObject performSelector:finishCallback
										   withObject:self];
			}
			
			[self stop];
		}
	}
	
	
}

- (void) startTimer
{
	if(!timer){
		
		[[SGEGameController sharedController]registerGameObject:self];
		
		timer = [NSTimer scheduledTimerWithTimeInterval:self.framesInterval
												 target:self selector:@selector(tick) userInfo:nil
												repeats:YES];
	}
}

- (void) stopTimer
{
	if(timer){
		
		[[SGEGameController sharedController] deregisterGameObject:self];
		[timer invalidate];
		timer = nil;
	}
}

- (void) start
{
	[self startTimer];
}

- (void) reset
{
	[self.sequence reset];
}

- (void) pause
{
	[self stopTimer];
}

- (void) stop
{
	if(returnToStart){
		[self.animationObject setSpriteFrame:self.originalSpriteFrame];
	}
	
	[self.sequence reset];

	[self stopTimer];
}

- (void) onPause
{
	[self stopTimer];
}

- (void) onContinue
{
	[self startTimer];
}

- (void) dealloc
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	
	[self stopTimer];
	
	self.sequence = nil;
	self.originalSpriteFrame = nil;
	
	[super dealloc];
}

@end
