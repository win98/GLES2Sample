//
//  EAGLViewController.m
//  GLES2Sample
//
//  Created by Sergey on 03.01.14.
//
//

#import "SGEGLViewController.h"

@interface SGEGLViewController ()

@end

@implementation SGEGLViewController

- (id)init
{
    self = [super init];
    if (self) {
		
		CGRect bounds = CGRectMake(0, 0, 480, 320);
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
