//
//  GTaskSender.h
//  Demo
//
//  Created by Grand on 2018/11/28.
//  Copyright © 2018 G.Y. All rights reserved.
//

/*
 thanks to promise
 
 //invocation - block
 https://github.com/deput/NSInvocation-Block
 */

#import <Foundation/Foundation.h>
#import "GTaskReciever.h"
#import "GTaskConfig.h"

@class GTaskSender, GTaskConfig;

extern GTaskSender * GFirstly(void (^block)(GTaskConfig *config));

@interface GTaskSender : NSObject

- (GTaskSender *(^)(void (^)(GTaskReciever *reciever)))then;

//you must set finally to start dispatch
- (void (^)(id block))finally;

@end

