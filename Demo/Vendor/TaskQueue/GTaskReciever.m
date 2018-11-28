//
//  GTaskReciever.m
//  Demo
//
//  Created by Grand on 2018/11/28.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import "GTaskReciever.h"
#import "GTaskSender.h"

#import <objc/runtime.h>

@interface GTaskSender (Private)
- (dispatch_semaphore_t)privateSemap;
- (NSInteger)taskCount;
@end

@implementation GTaskSender (Private)
@end


@implementation GTaskReciever

- (void)sendNextData:(id)data {
    _data = data;
    GTaskSender *sender = [self ownSender];
    dispatch_semaphore_signal(sender.privateSemap);
}

- (void)sendCompleted {
    GTaskSender *sender = [self ownSender];
    for (int i = 0; i < sender.taskCount; i ++) {
        dispatch_semaphore_wait(sender.privateSemap, DISPATCH_TIME_FOREVER);
    }
}

//MARK:- Getter
- (GTaskSender *)ownSender {
    GTaskSender *sender  = objc_getAssociatedObject(self, &"sender");
    return sender;
}

@end
