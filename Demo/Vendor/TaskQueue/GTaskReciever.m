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
@end

@implementation GTaskSender (Private)
@end


@implementation GTaskReciever

- (void)sendNextData:(id)data {
    _data = data;
    
    GTaskSender *sender  = objc_getAssociatedObject(self, &"sender");
    dispatch_semaphore_signal(sender.privateSemap);
}

- (void)sendCompleted {
    
}

@end
