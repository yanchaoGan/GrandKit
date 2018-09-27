//
//  GTableSection.h
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

#import "GTableCell.h"

typedef UIView *(^GTableSectionHeaderFooterView)(NSInteger section);

@interface GTableSection : NSObject

@property (nonatomic, copy) GTableSectionHeaderFooterView header;
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, copy) GTableSectionHeaderFooterView footer;
@property (nonatomic, assign) CGFloat footerHeight;

- (void)gAddRow:(void(^)(GTableCell *row))rowHandle;

//MARK: -Private
@property (nonatomic, strong) NSMutableArray <GTableCell *> *rows;

@end
