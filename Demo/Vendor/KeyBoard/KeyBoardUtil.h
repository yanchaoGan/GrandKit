//
//  KeyBoardUtil.h
//  Demo
//
//  Created by Grand on 2018/11/14.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIView+KeyBoard.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeyBoardUtil : NSObject

+ (instancetype)shared;

//default 50 pt
@property (nonatomic, assign) CGFloat keyboard_inputView_minDistance;

//default NO。 manual restart
@property (nonatomic, assign) BOOL keyboard_enable;

@end

NS_ASSUME_NONNULL_END
