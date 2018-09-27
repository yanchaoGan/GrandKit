//
//  GTableSection.m
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "GTableSection.h"

@interface GTableSection ()
@end

@implementation GTableSection

- (void)gAddRow:(void(^)(GTableCell *row))rowHandle {
    GTableCell *row = GTableCell.alloc.init;
    rowHandle(row);
    [self.rows addObject:row];
}

- (NSMutableArray *)rows {
    if (!_rows) {
        _rows = @[].mutableCopy;
    }
    return _rows;
}


@end
