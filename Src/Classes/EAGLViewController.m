//
//  EAGLViewController.m
//  GLES2Sample
//
//  Created by Sergey on 03.01.14.
//
//

#import "EAGLViewController.h"

@interface EAGLViewController ()

@end

@implementation EAGLViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		CGRect bounds = [[UIScreen mainScreen] bounds];
		self.view = [[EAGLView alloc] initWithFrame:bounds];
    }
    return self;
}

- (void)startAnimation
{
	[(EAGLView*)self.view startAnimation];
}

- (void)stopAnimation
{
	[(EAGLView*)self.view stopAnimation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}

@end
