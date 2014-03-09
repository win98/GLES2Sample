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
		
		self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

@end
