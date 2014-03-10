//
//  SGEGameController.m
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGEGameController.h"

static SGEGameController *instance;

static CGSize gameSceneSize;

static Class gameSceneClass;

@interface SGEGameController()

@property(nonatomic, retain) CADisplayLink *displayLink;

@end

@implementation SGEGameController

@synthesize viewController;
@synthesize screenFrameInterval;
@synthesize scene;

+ (SGEGameController*) sharedController
{
	if(!instance){
		
		instance = [[SGEGameController alloc]init];
	}
	
	return instance;
}

+ (void) setGameSceneSize:(CGSize)size
{
	gameSceneSize = size;
}

+ (void) setGameSceneClass:(Class)class
{
	NSAssert([class isSubclassOfClass:[SGEScene class]], @"Class %@ is not subclass of SGEScene class", class);
	
	gameSceneClass = class;
}

+ (CGSize)gameSceneSize
{
	return gameSceneSize;
}

- (id) init
{
	if(self = [super init]){
		
		self.scene = [[[gameSceneClass alloc]init]autorelease];
		
		SGEGLViewController *vc = [[[SGEGLViewController alloc]init]autorelease];
		[vc setTouchesDelegate:self.scene];
		[vc setMultiTouchEnabled:NO];
		self.viewController = vc;
		
		screenFrameInterval = 1;
		self.displayLink = nil;
		isAnimating = NO;
		
		prevTime = [NSDate timeIntervalSinceReferenceDate];
	}
	
	return self;
}

- (void) dealloc
{
	[self stop];
	[self.viewController setTouchesDelegate:nil];
	self.viewController = nil;
	self.scene = nil;
	
	[super dealloc];
}

- (void) update
{
	NSTimeInterval curTime = [NSDate timeIntervalSinceReferenceDate];
	
	[self.scene tick:(curTime - prevTime)];
	[self.scene drawContent];
	
	prevTime = curTime;
}

- (void) setScreenFrameInterval:(int)interval
{
	if(interval >= 1){
		screenFrameInterval = interval;
		
		if(isAnimating){
			[self stop];
			[self start];
		}
	}
}

- (void) start
{
	if (!isAnimating){
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [self.displayLink setFrameInterval:screenFrameInterval];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
		isAnimating = TRUE;
	}
}

- (void) stop
{
	if (isAnimating){
		[self.displayLink invalidate];
        self.displayLink = nil;
		
		isAnimating = FALSE;
	}
}

@end
