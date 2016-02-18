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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YFTableViewController";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 80;
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
        cell.editButtonArray = array;
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
}

@end
