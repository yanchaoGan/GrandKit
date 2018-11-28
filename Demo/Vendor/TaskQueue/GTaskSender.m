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

@interface GTaskSender () {
    dispatch_queue_t _queue;
}

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
        [self dispatchOnQueue];
    };
    return rt;
}

//MARK:- Private

- (void)dispatchOnQueue {
    dispatch_queue_t queue = dispatch_queue_create("task.dispatch.queue", DISPATCH_QUEUE_SERIAL);
    _queue = queue;
    dispatch_async(queue, ^{
        [self startDispatch];
    });
}

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
        
        
        objc_setAssociatedObject(recieverHandle, &"reciever", reciever, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        objc_setAssociatedObject(reciever, &"sender", self, OBJC_ASSOCIATION_ASSIGN);
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           
                           recieverHandle(reciever);
                       });
        dispatch_semaphore_wait(sp, DISPATCH_TIME_FOREVER);
    }
    //invoke finally block
    for (int i = 0; i < count - 0; i++) {
        dispatch_semaphore_wait(sp, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_signal(sp);
    }

    NSInvocation* invocation = [NSInvocation invocationWithBlock:self.finalBlock];
    
    NSInteger originCount = invocation.methodSignature.numberOfArguments;
    //block 比正常 类对象 方法少1
    NSAssert(originCount - 1 == self.tasks.count, @"接受参数个数必须等于task 数量");
    
    for (int i = 0; i < self.tasks.count; i++) {
        id handle = self.tasks[i];
        GTaskReciever *reciever = objc_getAssociatedObject(handle, &"reciever");
        if (reciever.data) {
            NSString *name = reciever.data; //for tmp
            [invocation setArgument:&name atIndex:i + 1];
        }
        else {
        }
    }
    self.tasks = @[].mutableCopy;
    dispatch_async(dispatch_get_main_queue(), ^{
       [invocation invoke];
    });
}


//MARK:- Getter
- (dispatch_semaphore_t)privateSemap {
    return self.semp;
}
- (NSInteger)taskCount {
    return self.tasks.count;
}

@end

