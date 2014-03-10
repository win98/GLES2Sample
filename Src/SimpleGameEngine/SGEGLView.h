//
//  SGEGLView.m
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import <UIKit/UIKit.h>

@protocol TouchesDelegateProtocol <NSObject>

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface SGEGLView : UIView

@property(nonatomic, assign) id<TouchesDelegateProtocol> touchesDelegate;

@end
