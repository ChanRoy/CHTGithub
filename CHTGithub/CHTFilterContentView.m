//
//  CHTFilterContentView.m
//  CHTGithub
//
//  Created by cht on 16/8/17.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTFilterContentView.h"
#import "CHTFilterItem.h"

#define VIEW_HEIGHT_SCALE 1/2

@interface CHTFilterContentView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, assign) CHTFilterType filterType;

@property (nonatomic, strong) NSArray <CHTFilterItem *> *dataSource;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *subTableView;

@end

@implementation CHTFilterContentView

- (instancetype)initWithFrame:(CGRect)frame filterType:(CHTFilterType)filterType dataSource:(NSArray *)dataSource{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _filterType = filterType;
        _dataSource = dataSource;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    switch (_filterType) {
        case CHTFilterTypeDefault:{
            [self setupDefaultContentView];
        }
            break;
        case CHTFilterTypeTwoFloor:{
            [self setupTwoFloorContentView];
        }
            break;
            
        default:
            break;
    }
}

- (void)setupTwoFloorContentView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) * 1/3, CGRectGetHeight(self.frame) * VIEW_HEIGHT_SCALE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [UIView new];
    [self addSubview:_tableView];
    
    _subTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_tableView.frame), 0, CGRectGetWidth(self.frame) * 2/3, CGRectGetHeight(self.frame) * VIEW_HEIGHT_SCALE) style:UITableViewStylePlain];
    _subTableView.delegate = self;
    _subTableView.dataSource = self;
    _subTableView.showsVerticalScrollIndicator = NO;
    _subTableView.tableFooterView = [UIView new];
    [self addSubview:_subTableView];
}

- (void)setupDefaultContentView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * VIEW_HEIGHT_SCALE) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [UIView new];
    [self addSubview:_tableView];
}

- (void)hide{
    
    [self removeFromSuperview];
    if (_hideBlock) {
        _hideBlock();
    }
}

#pragma mark - gesture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:self.class]) {
        return YES;
    }
    return NO;
}

- (void)tapEvent:(UITapGestureRecognizer *)tap{
    
    if ([tap.view isKindOfClass:self.class]) {
        [self hide];
    }
}


#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row].desc;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView) {
        
        if (_didSelectFilterItem) {
            _didSelectFilterItem(_dataSource[indexPath.row]);
        }
        
    }
    
    if (tableView == _subTableView) {
        
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
