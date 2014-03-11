//
//  EAGLViewController.h
//  GLES2Sample
//
//  Created by Sergey on 03.01.14.
//
//

#import <UIKit/UIKit.h>
#import "SGEGLView.h"

@interface SGEGLViewController : UIViewController

- (id)initWithFrame:(CGRect)frame;

- (void) setTouchesDelegate:(id)dlg;
- (void) setMultiTouchEnabled:(BOOL)enabled;
- (void) enableRetinaSupport:(BOOL)enable;

@end
