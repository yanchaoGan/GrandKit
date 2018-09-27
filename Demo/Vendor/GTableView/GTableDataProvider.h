//
//  GTableDataProvider.h
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GTableSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTableDataProvider : NSObject

@property (nonatomic, assign) Class defaultCell;  //UITableViewCell
@property (nonatomic, assign) CGFloat defaultHeight; //44

@property (nonatomic, copy) GTableSectionHeaderFooterView defaultHeader;
@property (nonatomic, assign) CGFloat defaultHeaderHeight;

@property (nonatomic, copy) GTableSectionHeaderFooterView defaultFooter;
@property (nonatomic, assign) CGFloat defaultFooterHeight;

//MARK: - Private
@property (nonatomic, weak) NSMutableArray <GTableSection *> *sections;

@end


NS_ASSUME_NONNULL_END
