//
//  GTableDataProvider.m
//  Demo
//
//  Created by Grand on 2018/9/25.
//  Copyright © 2018年 G.Y. All rights reserved.
//

#import "GTableDataProvider.h"
#import <UIKit/UITableView.h>

@interface GTableDataProvider () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation GTableDataProvider

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GTableSection *tsection = self.sections[section];
    return tsection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTableSection *tsection = self.sections[indexPath.section];
    GTableCell *trow = tsection.rows[indexPath.row];
    
    UITableViewCell *cell;
    if (trow.cellForRow) {
        cell = trow.cellForRow(tableView,indexPath);
    }
    else {
        if (!trow.cellClass) {
            trow.cellClass = self.defaultCell;
        }
        NSString *reuseId = NSStringFromClass(trow.cellClass);
        cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [(UITableViewCell *)[trow.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (trow.cellDisplay) {
        trow.cellDisplay(tableView,cell,indexPath);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTableSection *tsection = self.sections[indexPath.section];
    GTableCell *trow = tsection.rows[indexPath.row];
    return trow.rowHeight?:self.defaultHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTableSection *tsection = self.sections[indexPath.section];
    GTableCell *trow = tsection.rows[indexPath.row];
    if (trow.cellSelection) {
        trow.cellSelection(tableView, indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GTableSection *tsection = self.sections[section];
    GTableSectionHeaderFooterView header = tsection.header?:self.defaultHeader;
    if (header) {
        return header(section);
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    GTableSection *tsection = self.sections[section];
    return tsection.headerHeight?:self.defaultHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    GTableSection *tsection = self.sections[section];
    GTableSectionHeaderFooterView footer = tsection.footer?:self.defaultFooter;
    if (footer) {
        return footer(section);
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    GTableSection *tsection = self.sections[section];
    return tsection.footerHeight?:self.defaultFooterHeight;
}

@end
