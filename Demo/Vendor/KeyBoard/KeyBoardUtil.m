//
//  KeyBoardUtil.m
//  Demo
//
//  Created by Grand on 2018/11/14.
//  Copyright © 2018 G.Y. All rights reserved.
//

#import "KeyBoardUtil.h"
#import <UIKit/UIKit.h>

@interface KeyBoardUtil ()

@property (nonatomic, weak) UIView *inpuView;

@property (nonatomic, assign) CGRect lastKeyboardFrame;

@end


#define KB_Check \
if ([self checkCanResponse] == NO) { \
return; \
}

@implementation KeyBoardUtil

+ (instancetype)shared {
    static KeyBoardUtil *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] _init];
    });
    return _instance;
}

- (instancetype)_init
{
    self = [super init];
    if (self) {
        self.keyboard_inputView_minDistance = 50;
        self.keyboard_enable = YES;
        [self addObserver];
    }
    return self;
}

- (instancetype)init
{
    NSAssert(NO, @"must use shared");
    return self;
}

//MARK:- Input
- (void)tf_didBegin:(NSNotification *)notice {
    NSLog(@"%s",__func__);
    self.inpuView = notice.object;
    if (!CGRectIsEmpty(self.lastKeyboardFrame)) {
        [self keyboardToRect:self.lastKeyboardFrame interval:0.25];
    }
}

- (void)tf_endBegin:(NSNotification *)notice {
    NSLog(@"%s",__func__);
    if (self.inpuView == notice.object) {
        self.inpuView = nil;
    }
}

- (void)kb_keyboardFrameChange:(NSNotification *)notice {
    NSLog(@"%s",__func__);
    CGRect to = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.lastKeyboardFrame = to;
    
    KB_Check
    
    NSTimeInterval time = [notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self keyboardToRect:to interval:time];
    
    /*
     {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 260}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 797}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 537}";
     
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 260}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 407}, {375, 260}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     }
     */
}

//MARK:- Public
- (void)keyboardToRect:(CGRect)keyboardRectWin
              interval:(NSTimeInterval)time {
    
    UIWindow *keyWindow = [UIApplication.sharedApplication.delegate window];
    CGRect viewRectWin = [self.inpuView.superview convertRect:self.inpuView.frame toView:keyWindow];
    
    CGFloat viewYMax = CGRectGetMaxY(viewRectWin);
    CGFloat keyboardYMin = CGRectGetMinY(keyboardRectWin);
    
    if (keyboardYMin >= CGRectGetMaxY(keyWindow.frame)) {
        [self keyboardDismiss:time];
    }
    else {
        CGFloat diff = keyboardYMin - viewYMax;
        
        if (diff >= self.keyboard_inputView_minDistance) {
            //do nothing
        }
        else {
            //需要移动
            CGFloat moveDiff = self.keyboard_inputView_minDistance - diff;
            [self rootViewTopChange:moveDiff time:time];
        }
    }
}

#pragma mark - Animate

//Note: restore
- (void)keyboardDismiss:(NSTimeInterval)interval {
    UIView *rootView = self.inpuView.kb_superRootVc.view;
    CGRect frame = rootView.frame;
    frame.origin.y = rootView.kb_originFrame.origin.y;
//    @weakify(self);
    [UIView animateWithDuration:interval animations:^{
//        @strongify(self);
       rootView.frame = frame;
    }];
}

//Note: move up
- (void)rootViewTopChange:(CGFloat)diff time:(NSTimeInterval)interval {
    UIView *rootView = self.inpuView.kb_superRootVc.view;
    CGRect frame = rootView.frame;
    frame.origin.y -= diff;
    //    @weakify(self);
    [UIView animateWithDuration:interval animations:^{
        //        @strongify(self);
        rootView.frame = frame;
    }];
}

#pragma mark - Helper
- (void)addObserver {
    
    //textfield
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(tf_didBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(tf_endBegin:) name:UITextFieldTextDidEndEditingNotification object:nil];
    //text view
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(tf_didBegin:) name:UITextViewTextDidBeginEditingNotification object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(tf_endBegin:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    //keyboard
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(kb_keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (BOOL)checkCanResponse {
    if (!self.inpuView) {
        return NO;
    }
    if (self.inpuView.kb_superRootVc.kb_enable == NO) {
        return NO;
    }
    if (self.keyboard_enable == NO) {
        return NO;
    }
    return YES;
}

- (void)setInpuView:(UIView *)inpuView {
    _inpuView = inpuView;
    /**< get once origin frame*/
    _inpuView.kb_superRootVc.view.kb_originFrame;
}

@end
