//
//  ViewController.m
//  Demo
//
//  Created by ganyanchao on 2018/8/8.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "ViewController.h"
#import "OtherTestView.h"
#import "TestViewController.h"

#import <CoreFoundation/CoreFoundation.h>
#import "GTableKit.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import "KeyBoardUtil.h"

#import "GTaskSender.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;
@property (weak, nonatomic) IBOutlet UITextView *TV;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeyBoardUtil.shared.keyboard_enable = YES;
    self.kb_enable = YES;
    
    GFirstly(^(GTaskConfig *config) {
        config.concurrentCount = 1;
    }).then(^(GTaskReciever *reciever){
        NSLog(@"123");
        [reciever sendNextData:nil];
    }).then(^(GTaskReciever *reciever){
        NSLog(@"567");
        [reciever sendNextData:nil];
    }).
    finally(^(id data, id data1){
        NSLog(@"finally");
    });
    
    return;//
    UITableView *tv = [UITableView.alloc initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    
    [tv gSetupOriginDataSource:self originDelegate:self provider:^(GTableDataProvider *provider) {
       
        provider.defaultHeader = ^UIView *(NSInteger section) {
            UIView *view = UIView.alloc.init;
            view.backgroundColor = UIColor.redColor;
            return view;
        };
    }];
    
    [tv gAddSection:^(GTableSection *section) {
       
        [section gAddRow:^(GTableCell *row) {
            
            row.cellDisplay = ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
                cell.textLabel.text = @(indexPath.row).stringValue;
            };
            
        }];
    }];
    
    [tv reloadData];
}

@end
