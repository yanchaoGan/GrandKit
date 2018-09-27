//
//  GTableCell.h
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>

typedef UITableViewCell *(^GTableCellForRow)(UITableView *tableView,NSIndexPath *indexPath);
typedef void(^GTableCellDisplayAtRow)(UITableView *tableView,id cell,NSIndexPath *indexPath);
typedef void(^GTableCellSelection)(UITableView *tableView,NSIndexPath *indexPath);

@interface GTableCell : NSObject

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, copy) GTableCellDisplayAtRow cellDisplay;

//Optional
@property (nonatomic, copy) GTableCellForRow cellForRow;
@property (nonatomic, copy) GTableCellSelection cellSelection;

@end

