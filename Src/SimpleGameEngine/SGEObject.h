//
//  SGEObject.h
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import <Foundation/Foundation.h>

#define PI	3.14159f
#define SGE_PI_TO_DEGREES(angle) (angle * 180.f / PI)
#define SGE_DEGREES_TO_PI(angle) (angle * PI / 180.f)

#define mp(x, y) CGPointMake(x, y)
#define mc(r, g, b, a) SGEColorMake(r, g, b, a)

typedef struct _SGEQuad{
	CGPoint bl;
	CGPoint br;
	CGPoint tl;
	CGPoint tr;
} SGEQuad;

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


@interface SGEUtils : NSObject

float randomf(float n1, float n2);

@end

@interface SGEObject : NSObject

@end
