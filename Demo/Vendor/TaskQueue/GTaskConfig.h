//
//  GTaskConfig.h
//  Demo
//
//  Created by Grand on 2018/11/28.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTaskConfig : NSObject

@property (nonatomic, assign) NSInteger concurrentCount; // 0 1 means serial , default 0

@end

NS_ASSUME_NONNULL_END
