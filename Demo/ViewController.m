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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
