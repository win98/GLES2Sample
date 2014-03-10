//
//  EAGLViewController.m
//  GLES2Sample
//
//  Created by Sergey on 03.01.14.
//
//

#import "SGEGLViewController.h"
#import "SGEGameController.h"

@interface SGEGLViewController ()

@end

@implementation SGEGLViewController

- (id)init
{
    if (self = [super init]) {
		CGSize size = [SGEGameController gameSceneSize];
		CGRect bounds = CGRectMake(0, 0, size.width, size.height);
		self.view = [[SGEGLView alloc] initWithFrame:bounds];
    }
	
    return self;
}

- (void) setTouchesDelegate:(id)dlg
{
	((SGEGLView*)self.view).touchesDelegate = dlg;
}

- (void) setMultiTouchEnabled:(BOOL)enabled
{
	self.view.multipleTouchEnabled = enabled;
}

@end
