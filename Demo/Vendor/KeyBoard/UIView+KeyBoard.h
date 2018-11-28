//
//  UIView+KeyBoard.h
//  Demo
//
//  Created by Grand on 2018/11/14.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KeyBoard)

- (UIScrollView *)kb_superScrollView;
- (UIViewController *)kb_superRootVc;

/**< 第一次访问时，生成一次*/
@property (nonatomic, assign) CGRect kb_originFrame;

@end



@interface UIScrollView (KeyBoard)

@end


@interface UIViewController (KeyBoard)

//default yes.
//you can set no to disable KeyBoardUtil
@property (nonatomic, assign) BOOL kb_enable;

@end

NS_ASSUME_NONNULL_END
