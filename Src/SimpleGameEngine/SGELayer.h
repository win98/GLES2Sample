//
//  SGELayer.h
//  GLES2Sample
//
//  Created by Sergey on 09.03.14.
//
//

#import "SGENode.h"

@interface SGECamera : SGEObject

@property(nonatomic) CGPoint positionOnOwner;
@property(nonatomic) CGPoint positionOnScene;
@property(nonatomic, assign) SGENode *owner;

- (id) initWithOwner:(SGENode*)owner;
+ (id) cameraWithOwner:(SGENode*)owner;

@end

@interface SGELayer : SGENode

@property(nonatomic, retain) SGECamera *camera;

@end
