//
//  RootViewController.m
//  GLES2Sample
//
//  Created by Sergey on 03.01.14.
//
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    return self;
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
//
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
