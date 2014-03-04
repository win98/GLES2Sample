//
//  SGEAffineTransformation.m
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEAffineTransformation.h"

@implementation SGEAffineTransformation

+ (CGPoint) scale:(CGPoint)point factorX:(float)fX factorY:(float)fY
{
	CGPoint p = CGPointMake(point.x * fX,
							point.y * fY);
	
	return p;
}

+ (CGPoint) scale:(CGPoint)point node:(SGENode*)node
{
	CGPoint p = CGPointMake((point.x - node.anchorPoint.x) * node.scaleX + node.anchorPoint.x,
							(point.y - node.anchorPoint.y) * node.scaleY + node.anchorPoint.y);
	
	return p;
}

+ (CGPoint) rotate:(CGPoint)point angle:(float)angle
{
	angle = SGE_DEGREES_TO_PI(angle);
	float sinRot = sinf(angle);
	float cosRot = cosf(angle);
	float x = point.x;
	float y = point.y;
	
	CGPoint p = CGPointMake(x * cosRot - y * sinRot,
							x * sinRot + y * cosRot);
	
	return p;
}

+ (CGPoint) rotate:(CGPoint)point node:(SGENode*)node
{
	float angle = SGE_DEGREES_TO_PI(node.rotation);
	float sinRot = sinf(angle);
	float cosRot = cosf(angle);
	float x = point.x - node.anchorPoint.x;
	float y = point.y - node.anchorPoint.y;
	
	CGPoint p = CGPointMake(x * cosRot - y * sinRot + node.anchorPoint.x,
							x * sinRot + y * cosRot + node.anchorPoint.y);
	
	return p;
}

@end
