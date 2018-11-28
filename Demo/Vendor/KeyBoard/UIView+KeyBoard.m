//
//  UIView+KeyBoard.m
//  Demo
//
//  Created by Grand on 2018/11/14.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import "UIView+KeyBoard.h"
#import <objc/runtime.h>

@implementation UIView (KeyBoard)

- (UIScrollView *)kb_superScrollView {
    
    UIView *v = self;
    while (v) {
        if ([v isKindOfClass:UIScrollView.class]) {
            return v;
        }
        v = v.superview;
    }
    return nil;
}

- (UIViewController *)kb_superRootVc {
    UIResponder * v = self.nextResponder;
    while (v) {
        if ([v isKindOfClass:UIViewController.class]) {
            return v;
        }
        v = v.nextResponder;
    }
    return nil;
}

- (CGRect)kb_originFrame {
    
    NSValue *value = objc_getAssociatedObject(self, @selector(kb_originFrame));
    if (!value) {
        CGRect now = self.frame;
        self.kb_originFrame = now;
        value = [NSValue valueWithCGRect:now];
    }
    return [value CGRectValue];
}

- (void)setKb_originFrame:(CGRect)kb_originFrame {
    objc_setAssociatedObject(self, @selector(kb_originFrame), [NSValue valueWithCGRect:kb_originFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



@implementation UIScrollView (KeyBoard)

@end

@implementation UIViewController (KeyBoard)

- (void)setKb_enable:(BOOL)kb_enable {
    objc_setAssociatedObject(self, @selector(kb_enable), @(kb_enable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)kb_enable {
    id en = objc_getAssociatedObject(self, @selector(kb_enable));
    if (!en) {
        self.kb_enable = YES;
        en = @(YES);
    }
    return [en boolValue];
}

@end
