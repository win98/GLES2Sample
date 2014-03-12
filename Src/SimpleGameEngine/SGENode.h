//
//  SGENode.h
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "matrix.h"


@interface SGENode : SGEObject{
	
	kmMat4 transform;
	
	BOOL needToUpdatetransform;
	BOOL needToSortChildren;
}

@property(nonatomic) CGPoint position;
@property(nonatomic) CGPoint center;
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
@property(nonatomic) float alpha;
@property(nonatomic, retain) NSMutableArray *children;

- (id) initWithPosition:(CGPoint)pos;
- (id) initWithPosition:(CGPoint)pos z:(int)z_;

- (void) addChild:(SGENode*)child;
- (void) removeChild:(SGENode*)child;

- (void) tick:(float)dt;
- (void) process;

@end
