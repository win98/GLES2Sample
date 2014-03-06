//
//  SGENode.h
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"
#import <OpenGLES/ES1/gl.h>
#import "matrix.h"
#import "SGEAffineTransformation.h"

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
	
	kmMat4 transform;
	
	BOOL needToUpdatetransform;
	BOOL needToSortChildren;
}

@property(nonatomic) CGPoint position;
@property(nonatomic) CGSize contentSize;
@property(nonatomic) CGPoint anchorPoint;
@property(nonatomic, readonly) CGPoint anchorPointInPoints;
@property(nonatomic) float scale;
@property(nonatomic) float scaleX;
@property(nonatomic) float scaleY;
@property(nonatomic) float rotation;//CCW rotation in DEGREES
@property(nonatomic) SGEColor color;
@property(nonatomic) BOOL visible;
@property(nonatomic, assign) SGENode *parent;
@property(nonatomic) int z;
@property(nonatomic, retain) NSMutableArray *children;

- (id) initWithPosition:(CGPoint)pos;
- (void) addChild:(SGENode*)child;
- (void) removeChild:(SGENode*)child;

- (void) tick:(float)dt;
- (void) process;

@end
