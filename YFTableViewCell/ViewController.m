//
//  ViewController.m
//  YFTableViewCell
//
//  Created by 杨枫 on 15/11/3.
//  Copyright © 2015年 Saxue. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<YFTableViewDelegate>
{
    NSMutableArray      *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YFTableViewController";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<30; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"测试数据 %ld",i]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"tableviewcell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:[UIButton buttonWithTitle:@"置顶"
                                        titleColor:nil
                                   backgroundColor:kYFCellEditButtonMore]];
        [array addObject:[UIButton buttonWithTitle:@"标为未读"
                                        titleColor:nil
                                   backgroundColor:kYFCellEditButtonIsRead]];
        [array addObject:[UIButton buttonWithTitle:@"删除"
                                        titleColor:nil
                                   backgroundColor:kYFCellEditButtonDelele]];
//        [array addObject:[UIButton buttonWithImage:[UIImage imageNamed:@"icon_delete"]
//                                             title:nil
//                                        titleColor:nil
//                                   backgroundColor:kYFCellEditButtonDelele]];
        cell.editButtonArray = array;
    }
    
    if (_dataArray.count) {
        cell.titleLabel.text = _dataArray[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath:%@",indexPath);
}

- (void)tableView:(UITableView *)tableView didClickedEditButtonAtButtonIndex:(NSInteger)buttonIndex atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"buttonIndex:%ld",buttonIndex);
    
    /**
     *  响应点击事件 buttonIndex从左至右依次是 0，1，2，...
     */
    if (buttonIndex == 2) {     // 点击删除按钮
        if (_dataArray.count>0) {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [tableView endUpdates];
        }
    }
}

@end
