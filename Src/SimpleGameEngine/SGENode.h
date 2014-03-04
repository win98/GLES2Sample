//
//  SGENode.h
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"
#import <OpenGLES/ES1/gl.h>

typedef struct _SGEColor{
	float red;
	float green;
	float blue;
	float alpha;
} SGEColor;

static inline SGEColor SGEColorMake (float red, float green, float blue, float alpha)
{
	SGEColor color;
	color.red = red;
	color.green = green;
	color.blue = blue;
	color.alpha = alpha;
	
	return color;
}

@interface SGENode : SGEObject{
	
	NSMutableArray *children;
}

@property(nonatomic) CGPoint position;
@property(nonatomic, readonly) CGPoint globalPosition;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGPoint anchorPoint;
@property(nonatomic, readonly) CGPoint anchorPointInPoints;
@property(nonatomic) float scale;
@property(nonatomic) float scaleX;
@property(nonatomic) float scaleY;
@property(nonatomic) float rotation;//CCW rotation in DEGREES
@property(nonatomic, readonly) float globalRotation;
@property(nonatomic) SGEColor color;
@property(nonatomic) BOOL visible;
@property(nonatomic, assign) SGENode *parent;

- (id) initWithPosition:(CGPoint)pos;
- (void) addChild:(SGENode*)child;
- (void) removeChild:(SGENode*)child;

- (void) tick:(float)dt;
- (void) process;

@end
