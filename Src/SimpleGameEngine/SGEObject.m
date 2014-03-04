//
//  SGEObject.m
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"

@implementation SGEUtils

float randomf(float from, float to)
{
	float k = (float)random() / (float)0x7FFFFFFF;
	
	return (to - from) * k + from;
}

@end

@implementation SGEObject

@end
