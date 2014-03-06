//
//  SGEObject.m
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"

@implementation SGEUtils

float randomf(float n1, float n2)
{
	float k = (float)random() / (float)0x7FFFFFFF;
	
	return (n2 - n1) * k + n1;
}

@end

@implementation SGEObject

@end
