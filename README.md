# GrandKit
some Utils for work

## task queue 

like promise 
```
    GFirstly(^(GTaskConfig *config) {
        config.concurrentCount = 2;
    })
    .then(^(GTaskReciever *reciever){
        //mock any task. eg net work, io ...
        if (arc4random()%2 == 0) {
            sleep(3);
        }
        NSString * index = @(1).stringValue;
        NSLog(index);
        [reciever sendNextData:index];
        //if you send completed , queue will be pause
        //            [reciever sendCompleted];
    })
    .then(^(GTaskReciever *reciever){
        NSString * index = @(2).stringValue;
        NSLog(index);
        [reciever sendNextData:index];
    })
    .finally(^(id data1, id data2){
        NSLog(@"finally %@, %@",data1,data2);  //@"1" , @"2"
    });
```

## static tableview 
针对静态tableview ，极简构建方式。 
特别适合 设置、个人中心 场景

```
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
```
