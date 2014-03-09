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

@interface SGEUtils : NSObject

float randomf(float n1, float n2);

@end

@interface SGEObject : NSObject

@end
