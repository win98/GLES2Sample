//
//  SGEAffineTransformation.h
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"
#import "SGENode.h"

#define PI	3.14159f
#define SGE_PI_TO_DEGREES(angle) (angle * 180.f / PI)
#define SGE_DEGREES_TO_PI(angle) (angle * PI / 180.f)

@interface SGEAffineTransformation : SGEObject

+ (CGPoint) scale:(CGPoint)point factorX:(float)fX factorY:(float)fY;
+ (CGPoint) scale:(CGPoint)point node:(SGENode*)node;
+ (CGPoint) rotate:(CGPoint)point angle:(float)angle;
+ (CGPoint) rotate:(CGPoint)point node:(SGENode*)node;

@end
