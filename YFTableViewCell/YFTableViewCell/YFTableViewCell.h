//
//  YFTableViewCell.h
//  YFTableViewCell
//
//  Created by 杨枫 on 15/11/3.
//  Copyright © 2015年 Saxue. All rights reserved.
//

/**
 *  本人英文名 Saxue 已经更为 Dandre
 *  个人博客：http://yangfeng.pw
 *  YFTableViewCell下载：https://github.com/saxueyang/YFTableViewCell
 *  优点：
 *  1.支持代码和.xib等方式自定义tableViewCell
 *  2.使用简单，继承于YFTableViewCell即可
 *
 *  使用步骤：
 *  1.将你的tableViewCell继承于YFTableViewCell
 *  2.设置cell.delegate = self;
 *  3.设置cell.editButtonArray = array;(array为存有 __kindof UIButton 的数组)
 *  4.实现两个代理方法
 *      - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 *      - (void)tableView:(UITableView *)tableView didClickedEditButtonAtButtonIndex:(NSInteger)buttonIndex atIndexPath:(NSIndexPath *)indexPath
 *  注：第二个代理方法里的操作相见Demo
 *     下一版本将支持swift
 */

#import <UIKit/UIKit.h>

extern NSString *const YFTableViewCellNSNotification;

@protocol YFTableViewDelegate <NSObject,UITableViewDelegate>

@required
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView didClickedEditButtonAtButtonIndex:(NSInteger)buttonIndex atIndexPath:(NSIndexPath *)indexPath;

@end

@interface YFTableViewCell : UITableViewCell<UIScrollViewDelegate>

/**
 *  底部的scrollView
 */
@property (nonatomic, strong) UIScrollView      *scrollView;
/**
 *  编辑视图下得按钮数组 (数组里存放的是 __kindof UIButton *)
 */
@property (nonatomic, strong) NSMutableArray    *editButtonArray;
/**
 *  代理 必须实现 否则点击Cell失效
 */
@property (nonatomic, weak) id <YFTableViewDelegate> delegate;

@end

#define kYFCellEditButtonDelele [UIColor redColor]
#define kYFCellEditButtonMore   [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]
#define kYFCellEditButtonOther  [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1]
#define kYFCellEditButtonIsRead [UIColor colorWithRed:240/255.0 green:164/255.0 blue:24/255.0  alpha:1]

@interface UIButton (YFTableViewCell)

/**
 *  根据标题、标题颜色、背景颜色创建Button
 *
 *  @param title      按钮上的文字
 *  @param titleColor 文字颜色
 *  @param bgColor    按钮背景颜色
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)bgColor;
/**
 *  根据图标、标题、标题颜色、背景颜色创建Button
 *
 *  @param image      按钮上的图片
 *  @param title      按钮上的文字
 *  @param titleColor 文字颜色
 *  @param bgColor    按钮背景颜色
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithImage:(UIImage *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)bgColor;

@end