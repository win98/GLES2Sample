//
//  SGENode.m
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGENode.h"
#import "SGELog.h"
#import "SGEAffineTransformation.h"

@implementation SGENode

@synthesize position;
@synthesize globalPosition;
@synthesize contentSize;
@synthesize anchorPoint;
@synthesize anchorPointInPoints;
@synthesize scale;
@synthesize scaleX;
@synthesize scaleY;
@synthesize rotation;
@synthesize globalRotation;
@synthesize color;
@synthesize visible;
@synthesize parent;

- (id) init
{
	if([super init]){
		
		children = [[NSMutableArray alloc]init];
		
		self.contentSize = CGSizeMake(0, 0);
		self.anchorPoint = CGPointMake(0, 0);
		self.scale = 1.0f;
		self.rotation = 0;
		self.visible = YES;
		
		self.color = SGEColorMake(1.f, 1.f, 1.f, 1.f);
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

- (void) setAnchorPoint:(CGPoint)anchorPoint_
{
	anchorPoint = anchorPoint_;
	
	anchorPointInPoints = CGPointMake(contentSize.width * anchorPoint_.x,
									  contentSize.height * anchorPoint_.y);
}

- (void) setPosition:(CGPoint)position_
{
	position = position_;
	float x = position_.x;
	float y = position_.y;
	
	SGENode *node = self;
	while ((node = node.parent)) {
		x += node.position.x;
		y += node.position.y;
	}
	
	globalPosition = CGPointMake(x, y);
}

- (void) setScale:(float)scale_
{
	scale = scale_;
	
	if(children.count){
		for(SGENode *child in children){
			[child setScale:scale_];
		}
	}
}

- (void) setScaleX:(float)scaleX_
{
	scaleX = scaleX_;
	
	if(children.count){
		for(SGENode *child in children){
			[child setScaleX:scaleX_];
		}
	}
}

- (void) setScaleY:(float)scaleY_
{
	scaleY = scaleY_;
	
	if(children.count){
		for(SGENode *child in children){
			[child setScaleY:scaleY_];
		}
	}
}

- (void) setRotation:(float)rotation_
{
	rotation = rotation_;
	float r = rotation_;
	
	if(children.count){
		for(SGENode *child in children){
			r += rotation_;
		}
	}
	
	globalRotation = r;
}

- (void) addChild:(SGENode*)child
{	
	if(![children containsObject:child]){
		
		child.parent = self;
		[child onAdded];
		[children addObject:child];
	} else {
		
		SGELog(@"!Child is already added");
	}
}

- (void) removeChild:(SGENode*)child
{
	if(![children containsObject:child]){
		
		child.parent = nil;
		[child onRemoved];
		[children removeObject:child];
	} else {
		
		SGELog(@"!Child not found");
	}
}

- (void) onAdded
{
	float x = self.position.x;
	float y = self.position.y;
	float sx = self.parent.scaleX;
	
	SGENode *node = self;
	while ((node = node.parent)) {
		x += node.position.x;
		y += node.position.y;
	}
}

- (void) onRemoved
{
	
}

- (void) tick:(float)dt
{
	
}

- (void) draw
{
	
}

- (void) process
{
	if(!visible){
		return;
	}
	
	if(children.count){
		
		[self draw];
		
		for(SGENode *child in children){
			[child process];
		}
	} else {
		
		[self draw];
	}
}

- (void) dealloc
{
	[children release];
	
	[super dealloc];
}

@end
