//
//  SGELog.h
//  GLES2Sample
//
//  Created by Sergey on 01.03.14.
//
//

#import "SGEObject.h"

#define SGELog(message) [SGELog log:message]

@interface SGELog : SGEObject

+(void)log:(NSString*)message;

@end
