//
//  YFTableViewCell.m
//  YFTableViewCell
//
//  Created by 杨枫 on 15/11/3.
//  Copyright © 2015年 Saxue. All rights reserved.
//

#import "YFTableViewCell.h"

NSString *const YFTableViewCellNSNotification = @"YFTableViewCellNSNotification";

typedef NS_ENUM(NSInteger, YFTableViewCellState) {
    YFTableViewCellStateCenter  = 0,
    YFTableViewCellStateLeft    = 1,
    YFTableViewCellStateRight   = 2,
};

@implementation YFTableViewCell
{
    YFTableViewCellState    _cellState;
    UIView                  *_rightButtonsView;
    UIView                  *_backgroundView;
    CGFloat                 _lastOffset;
}

@synthesize backgroundView = _backgroundView;

- (void)setEditButtonArray:(NSMutableArray *)editButtonArray
{
    if (_editButtonArray.count) {
        [_editButtonArray removeAllObjects];
    }
    
    _editButtonArray = editButtonArray;
}

- (void)drawRect:(CGRect)rect
{
    if (self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        self.scrollView.delegate = self;
        self.scrollView.tag = 0x80000;
        self.scrollView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapClicked:)];
        [self.scrollView addGestureRecognizer:tap];
        
        _rightButtonsView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds), 0, [self rightButtonsViewWidth], CGRectGetHeight(self.bounds))];
        [self.scrollView addSubview:_rightButtonsView];
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_backgroundView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(YFTableViewCellNotification:)
                                                     name:YFTableViewCellNSNotification
                                                   object:nil];
    }
    _backgroundView.backgroundColor = self.backgroundColor;
    self.scrollView.contentOffset = CGPointZero;
    _rightButtonsView.frame = CGRectMake(CGRectGetWidth(self.bounds), 0, [self rightButtonsViewWidth], CGRectGetHeight(self.bounds));
    
    for (NSInteger i=0; i<self.editButtonArray.count; i++) {
        UIButton *btn = self.editButtonArray[i];
        btn.frame = CGRectMake(i*80, 0, 80, self.frame.size.height);
        [_rightButtonsView addSubview:btn];
        btn.tag = 10000 +i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + [self rightButtonsViewWidth], 0);
    
    self.scrollView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIScrollView class]] && view.tag == 0x80000) {
            NSLog(@"this is self.scrollView!");
        }else{
            [self.scrollView addSubview:view];
        }
    }
}

- (CGFloat)rightButtonsViewWidth
{
    return self.editButtonArray.count*80;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
- (void)YFTableViewCellNotification:(NSNotification *)info
{
    id obj = info.object;
    if (obj!=self) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.scrollView.contentOffset = CGPointZero;
                         }];
    }
}


- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YFTableViewCellNSNotification
                                                        object:self];
    if (self.scrollView.contentOffset.x!=0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointZero;
        }];
        return;
    }
    
    if (self.delegate) {
        
        UITableView *tableview = (UITableView *)[[self superview] superview];
        
        if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.delegate tableView:tableview didSelectRowAtIndexPath:[tableview indexPathForCell:self]];
        }else{
            NSLog(@"代理未实现-(void)tableView:didSelectRowAtIndexPath:");
        }
    }else{
        NSLog(@"未设置代理！");
    }
}

- (void)btnClicked:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointZero;
    }];
    
    if (self.delegate) {
        UITableView *tableview = (UITableView *)[[self superview] superview];
        
        if ([self.delegate respondsToSelector:@selector(tableView:didClickedEditButtonAtButtonIndex:atIndexPath:)]) {
            [self.delegate tableView:tableview
   didClickedEditButtonAtButtonIndex:sender.tag - 10000
                         atIndexPath:[tableview indexPathForCell:self]];
        }else{
            NSLog(@"代理未实现-(void)tableView:didSelectRowAtIndexPath:");
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YFTableViewCellNSNotification
                                                        object:self];
    if (scrollView.contentOffset.x <= _rightButtonsView.frame.size.width) {
        CGRect rect = _rightButtonsView.frame;
        rect.origin.x = CGRectGetWidth(self.bounds) - rect.size.width + scrollView.contentOffset.x;
        _rightButtonsView.frame = rect;
    }
    [self.scrollView sendSubviewToBack:_rightButtonsView];
    
    _cellState = YFTableViewCellStateLeft;
    if (_lastOffset>scrollView.contentOffset.x) {
        _cellState = YFTableViewCellStateCenter;
    }
    
    _lastOffset = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_rightButtonsView.frame.origin.x >= CGRectGetWidth(self.bounds)) {
        CGRect rect = _rightButtonsView.frame;
        rect.origin.x = CGRectGetWidth(self.bounds);
        _rightButtonsView.frame = rect;
    }else{
        CGRect rect = _rightButtonsView.frame;
        rect.origin.x = CGRectGetWidth(self.bounds) - rect.size.width;
        _rightButtonsView.frame = rect;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    switch (_cellState) {
        case YFTableViewCellStateCenter:
        {
            targetContentOffset->x = 0;
        }
            break;
        case YFTableViewCellStateLeft:
        {
            if (scrollView.contentOffset.x >=[self rightButtonsViewWidth]/2) {
                targetContentOffset->x = [self rightButtonsViewWidth];
            }else{
                targetContentOffset->x = 0;
            }
        }
            break;
            
        default:
            break;
    }
}

@end

@implementation UIButton (YFTableViewCell)

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)bgColor
{
    if (titleColor==nil) {
        titleColor = [UIColor whiteColor];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return btn;
}

+ (UIButton *)buttonWithImage:(UIImage *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)bgColor
{
    if (titleColor==nil) {
        titleColor = [UIColor whiteColor];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    [btn setImage:image forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return btn;
}

@end

