//
//  TestViewController.m
//  Demo
//
//  Created by ganyanchao on 2018/8/18.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "TestViewController.h"
#import "OtherTestView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    // Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showContent];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)showContent {
    
    OtherTestView *tv = [[[NSBundle mainBundle] loadNibNamed:@"OtherTestView" owner:nil options:nil] firstObject];
    [self.view addSubview:tv];
    tv.frame = self.view.bounds;
    
    [UIView animateWithDuration:5
                          delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionLayoutSubviews animations:^{
                              tv.bottom.constant = -300;
                              [tv layoutIfNeeded];
                          } completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
