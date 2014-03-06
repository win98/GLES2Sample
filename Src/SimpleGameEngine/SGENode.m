//
//  SGENode.m
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGENode.h"
#import "SGELog.h"

@implementation SGENode

@synthesize position;
@synthesize contentSize;
@synthesize anchorPoint;
@synthesize anchorPointInPoints;
@synthesize scale;
@synthesize scaleX;
@synthesize scaleY;
@synthesize rotation;
@synthesize color;
@synthesize visible;
@synthesize parent;
@synthesize z;
@synthesize children;

- (id) init
{
	if([super init]){
		
		children = [[NSMutableArray alloc]init];
		
		contentSize = CGSizeMake(0, 0);
		anchorPoint = CGPointMake(0, 0);
		scale = 1.0f;
		scaleX = 1.0f;
		scaleY = 1.0f;
		rotation = 0;
		visible = YES;
		z = 0;
		color = SGEColorMake(1.f, 1.f, 1.f, 1.f);
		
		needToUpdatetransform = YES;
		needToSortChildren = NO;
	}
	
	return self;
}

- (id) initWithPosition:(CGPoint)pos
{
	if([self init]){
		
		self.position = pos;
	}
	
	return self;
}

- (NSString*)description
{
	NSString *desc = [NSString stringWithFormat:
		@"\n%@<0x%X>: parent = %@<0x%X>,\nposition = {%.2f, %.2f}, size = {%.2f, %.2f}",
		[self class],(int)self, [parent class], (int)parent, position.x, position.y, contentSize.width, contentSize.height];
	
	return desc;
}

- (void) setScale:(float)scale_
{
	scale = scale_;
	scaleX = scale_;
	scaleY = scale_;
	
	needToUpdatetransform = YES;
}

- (void) setScaleX:(float)scaleX_
{
	scaleX = scaleX_;
	
	needToUpdatetransform = YES;
}

- (void) setScaleY:(float)scaleY_
{
	scaleY = scaleY_;
	
	needToUpdatetransform = YES;
}

- (void) setPosition:(CGPoint)position_
{
	position = position_;
	
	needToUpdatetransform = YES;
}

- (void) setAnchorPoint:(CGPoint)anchorPoint_
{
	anchorPoint = anchorPoint_;
	
	anchorPointInPoints = CGPointMake(contentSize.width * anchorPoint_.x,
									  contentSize.height * anchorPoint_.y);
	
	needToUpdatetransform = YES;
}

- (void) setZ:(int)z_
{
	z = z_;
	
	needToSortChildren = YES;
}

- (void) setRotation:(float)rotation_
{
	rotation = rotation_;
	
	needToUpdatetransform = YES;
}

- (void) addChild:(SGENode*)child
{
	if(![children containsObject:child]){
		
		child.parent = self;
		[children addObject:child];
		needToSortChildren = YES;
	} else {
		
		SGELog(@"!Child is already added");
	}
}

- (void) removeChild:(SGENode*)child
{
	if([children containsObject:child]){
		
		child.parent = nil;
		[children removeObject:child];
	} else {
		
		SGELog(@"!Child not found");
	}
}

- (void) tick:(float)dt
{
	
}

- (void) draw
{
	
}

//TODO: test sorting and implement color of children

- (void) sortChildren
{
	if(needToSortChildren && [children count]) {
		
		self.children = [[NSMutableArray arrayWithArray:
						  [children sortedArrayUsingComparator:^(id obj1, id obj2){
								NSComparisonResult res = ((SGENode*)obj1).z <= ((SGENode*)obj2).z ?
															NSOrderedAscending
															: NSOrderedDescending;
					
								return res;}
						   ]]retain];
		
		needToSortChildren = NO;
	}
}

- (void) transform
{
	if(needToUpdatetransform){
		kmMat4Identity(&transform);
		
		kmMat4 matrix;
		kmMat4 tmp;
		
		kmMat4Translation(&matrix,
						  self.position.x + self.anchorPointInPoints.x,
						  -self.position.y - self.anchorPointInPoints.y,
						  0);
		kmMat4Multiply(&tmp, &transform, &matrix);
		kmMat4RotationZ(&matrix, SGE_DEGREES_TO_PI(self.rotation));
		kmMat4Multiply(&transform, &tmp, &matrix);
		kmMat4Scaling(&matrix, scaleX, scaleY, 1);
		kmMat4Multiply(&tmp, &transform, &matrix);
		kmMat4Assign(&transform, &tmp);
		
		needToUpdatetransform = NO;
	}
	
	kmGLMultMatrix(&transform);
}

- (void) process
{
	if(!visible){
		return;
	}
	
	kmGLPushMatrix();
	
	[self transform];
	[self sortChildren];
	[self draw];
	
	if(children.count){
		
		for(SGENode *child in children){
			[child process];
		}
	}
	
	kmGLPopMatrix();
}

- (void) dealloc
{
	self.children = nil;
	
	[super dealloc];
}

@end
