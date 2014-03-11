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

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
		
		self.view = [[SGEGLView alloc] initWithFrame:frame];
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

- (void) enableRetinaSupport:(BOOL)enable
{
	self.view.contentScaleFactor = enable ? 2.0f : 1.0f;
}

@end
