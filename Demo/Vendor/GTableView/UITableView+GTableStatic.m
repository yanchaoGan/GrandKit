//
//  UITableView+GTableStatic.m
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "UITableView+GTableStatic.h"
#import <objc/runtime.h>

@implementation UITableView (GTableStatic)

- (void)gSetupOriginDataSource:(id)dataSource
                originDelegate:(id)delegate
                      provider:(GTableProviderHandle)providerHandle {
    
    if (providerHandle) {
        providerHandle(self.gDataProvider);
    }
    self.gDataProvider.sections = self.gSections;
    if (!self.gDataProvider.defaultHeight) {
        self.gDataProvider.defaultHeight = 44;
    }
    if (!self.gDataProvider.defaultCell) {
        self.gDataProvider.defaultCell = UITableViewCell.class;
    }
    
    [self.gDelegateContainer addDelegate:dataSource];
    [self.gDelegateContainer addDelegate:delegate];
    [self.gDelegateContainer addDelegate:self.gDataProvider];
    
    self.dataSource = self.gDelegateContainer;
    self.delegate = self.gDelegateContainer;
    
    //尾部
    UIView *footer = UIView.new;
    footer.frame = CGRectMake(0, 0, 1, CGFLOAT_MIN);
    self.tableFooterView = footer;
}

- (void)gAddSection:(void(^)(GTableSection *section))sectionHandle {
    GTableSection *section = GTableSection.alloc.init;
    sectionHandle(section);
    [self.gSections addObject:section];
}

- (void)gClearData {
    [self.gSections removeAllObjects];
}

//MARK: - Getter
- (NSMutableArray *)gSections {
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}

- (GTableDataProvider *)gDataProvider {
    GTableDataProvider *provider = objc_getAssociatedObject(self, _cmd);
    if (!provider) {
        provider = GTableDataProvider.alloc.init;
        objc_setAssociatedObject(self, _cmd, provider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return provider;
}

- (GTableDelegateContainer *)gDelegateContainer {
    GTableDelegateContainer *container = objc_getAssociatedObject(self, _cmd);
    if (!container) {
        container = GTableDelegateContainer.alloc.init;
        objc_setAssociatedObject(self, _cmd, container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return container;
}

@end
