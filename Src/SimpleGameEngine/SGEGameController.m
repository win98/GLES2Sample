//
//  SGEGameController.m
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGEGameController.h"

static SGEGameController *instance;

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

- (id) init
{
	if(self = [super init]){
		
		CGSize size = [SGEGameController screenSize];
		scale = [[UIScreen mainScreen] scale];
		
		isRetina = (scale > 1.0f) ? YES : NO;
		
		self.scene = [[[gameSceneClass alloc]init]autorelease];
		
		self.scene.contentSize = CGSizeMake(size.width * scale,
											size.height * scale);
		
		SGEGLViewController *vc = [[[SGEGLViewController alloc]initWithFrame:
									CGRectMake(0, 0, size.width, size.height)]autorelease];
		[vc enableRetinaSupport:isRetina];
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

+ (void) setGameSceneClass:(Class)class
{
	NSAssert([class isSubclassOfClass:[SGEScene class]], @"Class %@ is not subclass of SGEScene class", class);
	
	gameSceneClass = class;
}

- (BOOL) isRetina
{
	return isRetina;
}

- (float) scale
{
	return scale;
}

- (CGSize)gameSceneSize
{
	return self.scene.contentSize;
}

+ (CGSize)screenSize
{
	CGSize curSize = [[UIScreen mainScreen] bounds].size;
	CGSize size;
	
	NSObject<UIApplicationDelegate> *dlg =
	[[UIApplication sharedApplication] delegate];
	
	UIInterfaceOrientation or =	[[UIApplication sharedApplication]
								 supportedInterfaceOrientationsForWindow:dlg.window];
	
	if(or & UIInterfaceOrientationMaskLandscapeLeft
	|| or & UIInterfaceOrientationMaskLandscapeRight){
		size = CGSizeMake(MAX(curSize.width, curSize.height),
						  MIN(curSize.width, curSize.height));
	}
	
	if(or & UIInterfaceOrientationMaskPortrait
	|| or & UIInterfaceOrientationMaskPortraitUpsideDown){
		size = CGSizeMake(MIN(curSize.width, curSize.height),
						  MAX(curSize.width, curSize.height));
	}
	
	return size;
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
