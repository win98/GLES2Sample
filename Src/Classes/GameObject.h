//
//  GameObject.h
//  GLES2Sample
//
//  Created by Sergey on 16.03.14.
//
//

#import "SGESprite.h"
#import "Box2D.h"

@interface GameObject : SGESprite

@property(nonatomic, assign) b2Body *body;

@end
