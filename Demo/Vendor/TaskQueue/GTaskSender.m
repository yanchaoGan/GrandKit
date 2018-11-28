//
//  GTaskSender.m
//  Demo
//
//  Created by Grand on 2018/11/28.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import "GTaskSender.h"
#import "NSInvocation+Block.h"

#import <objc/runtime.h>

@interface GTaskSender ()

@property (nonatomic, strong) GTaskConfig *config;
@property (nonatomic, strong) NSMutableArray<void(^)(GTaskReciever *)> *tasks;

@property (nonatomic, copy) id finalBlock;
@property (nonatomic, strong) dispatch_semaphore_t semp;

@end

GTaskSender * GFirstly(void (^block)(GTaskConfig *config)) {
    GTaskSender *sender = GTaskSender.alloc.init;
    GTaskConfig *config = GTaskConfig.alloc.init;
    sender.config = config;
    block(config);
    return sender;
}


@implementation GTaskSender

- (void)dealloc {
    NSLog(@"%s",__func__);
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tasks = NSMutableArray.array;
    }
    return self;
}

//MARK:- Public
- (GTaskSender *(^)(void (^)(GTaskReciever *reciever)))then {
    
    GTaskSender *(^rt)(void (^)(GTaskReciever *reciever))
    
    = ^GTaskSender * (void(^recieverHandle)(GTaskReciever *)) {
        [self.tasks addObject:recieverHandle];
        return self;
    };
    return rt;
}

- (void (^)(id block))finally {
    void (^rt)(id block) =
    ^(id block){
        self.finalBlock = block;
        [self startDispatch];
    };
    return rt;
}

//MARK:- Private

- (void)startDispatch {
    
    //采用信号量的方式 并发同步
    NSInteger count = self.config.concurrentCount - 1;
    count = MAX(0, count);
    dispatch_semaphore_t sp = dispatch_semaphore_create(count);
    self.semp = sp;
    
    for (id handle in self.tasks) {
        void(^recieverHandle)(GTaskReciever *);
        recieverHandle = handle;
        GTaskReciever *reciever = GTaskReciever.alloc.init;
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                          
                           recieverHandle(reciever);
                       });
        
        objc_setAssociatedObject(recieverHandle, &"reciever", reciever, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        objc_setAssociatedObject(reciever, &"sender", self, OBJC_ASSOCIATION_ASSIGN);
        
        dispatch_semaphore_wait(sp, DISPATCH_TIME_FOREVER);
    }
    
    //invoke finally block
    
    NSInvocation* invocation = [NSInvocation invocationWithBlock:self.finalBlock];
    
    for (int i = 0; i < self.tasks.count; i++) {
        id handle = self.tasks[i];
        GTaskReciever *reciever = objc_getAssociatedObject(handle, &"reciever");
        if (reciever.data) {
            [invocation setArgument:(void *)(reciever.data) atIndex:i + 1];
        }
        else {
//            [invocation setArgument:(void *)[NSNull null] atIndex:i + 1];
        }
    }
    
    [invocation invoke];
    
    
}


//MARK:- Getter
- (dispatch_semaphore_t)privateSemap {
    return self.semp;
}

@end

