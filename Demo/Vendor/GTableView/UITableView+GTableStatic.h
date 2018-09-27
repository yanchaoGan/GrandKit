//
//  UITableView+GTableStatic.h
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTableKit.h"

typedef void(^GTableProviderHandle)(GTableDataProvider *provider);

@interface UITableView (GTableStatic)

- (void)gSetupOriginDataSource:(id)dataSource
                originDelegate:(id)delegate
                      provider:(GTableProviderHandle)providerHandle;

- (void)gAddSection:(void(^)(GTableSection *section))sectionHandle;
- (void)gClearData;

@end

