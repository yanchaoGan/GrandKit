//
//  GTaskReciever.h
//  Demo
//
//  Created by Grand on 2018/11/28.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTaskReciever : NSObject

@property (nonatomic, readonly) id data;
- (void)sendNextData:(id)data;

//nt 想结束一个sender queue
//with issue
//- (void)sendCompleted;

@end

NS_ASSUME_NONNULL_END
