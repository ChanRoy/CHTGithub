//
//  CHTFilterItemBar.m
//  CHTGithub
//
//  Created by cht on 16/8/17.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTFilterItemBar.h"
#import "CHTLayoutButton.h"
#import "CHTFilterContentView.h"
#import "CHTFilterItem.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BUTTON_START_TAG 100

@interface CHTFilterItemBar ()

@property (nonatomic, weak) UIView *parentView;

@property (nonatomic, strong) CHTLayoutButton *selectBtn;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) CHTFilterContentView *contentView;

@property (nonatomic, strong) NSArray <NSNumber *> *filterTypes;

@property (nonatomic, strong) NSMutableDictionary *itemDict;

@end


@implementation CHTFilterItemBar

- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)parentView{

    self = [super initWithFrame:frame];
    if (self) {
        
        _parentView = parentView;
        [_parentView addSubview:self];
        
        [self initialize];
        
    }
    return self;
}

- (void)initialize{
    
    _normalIcon = [UIImage imageNamed:@"cht_btn_no"];
    _selectIcon = [UIImage imageNamed:@"cht_btn_sl"];
    _normalColor = [UIColor blackColor];
    _selectColor = CHTTINT_COLOR;
    
    if (_delegate && [_delegate respondsToSelector:@selector(filterTypeOfFilterItemBar:)]) {
        
        _filterTypes = [_delegate filterTypeOfFilterItemBar:self];
    }
    
}

- (void)showContentView{
    
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    CHTFilterType filterType = _filterTypes[_selectIndex].integerValue;
    
    NSArray *dataSource;
    if (_delegate && [_delegate respondsToSelector:@selector(dataSourceOfFilterItemBar:didSelectButtonIndex:)]) {
        dataSource = [_delegate dataSourceOfFilterItemBar:self didSelectButtonIndex:_selectIndex];
    }
    
    _contentView = [[CHTFilterContentView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(_parentView.frame) - CGRectGetHeight(self.frame)) filterType:filterType dataSource:dataSource];
    __weak typeof(self) weakSelf = self;
    _contentView.hideBlock = ^{
        
        [weakSelf btnClick:weakSelf.selectBtn];
    };
    NSString *key = [NSString stringWithFormat:@"CHT%ld",(long)_selectIndex];
    _contentView.didSelectFilterItem = ^(CHTFilterItem *filterItem){
        
        [weakSelf.itemDict setObject:filterItem forKey:key];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(filterItemBar:didSelectFilterItem:)]) {
            [weakSelf.delegate filterItemBar:weakSelf didSelectFilterItem:filterItem];
        }
        [weakSelf btnClick:weakSelf.selectBtn];
    };
    [_parentView addSubview:_contentView];
    
    [self reloadItemBar];
}

#pragma mark - work

- (void)hideContentView{
    
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
}

- (void)layoutLines{
    
    UIView *hozLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5)];
    hozLine.backgroundColor = UIColorFromHex(0xe5e5e5);
    [self addSubview:hozLine];
    
    CGFloat width = SCREEN_WIDTH / _titles.count;
    for (NSInteger i = 1; i < _titles.count; i ++) {
        
        UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake(width * i, 0, 0.5, CGRectGetHeight(self.frame))];
        verLine.backgroundColor = UIColorFromHex(0xe5e5e5);
        [self addSubview:verLine];
    }
}

- (void)initItemDict{
    
    _itemDict = [NSMutableDictionary new];
    for (NSInteger i = 0; i < _titles.count; i ++) {
        
        CHTFilterItem *item = [[CHTFilterItem alloc]initWithDesc:_titles[i]];
        NSString *key = [NSString stringWithFormat:@"CHT%ld",(long)i];
        [_itemDict setObject:item forKey:key];
    }
}

#pragma mark - set methods

- (void)setTitles:(NSArray *)titles{
    
    if (_titles == titles) {
        return;
    }
    _titles = titles;
    
    for (UIView *view in self.subviews) {
    
        [view removeFromSuperview];
    }
    
    CGFloat width = CGRectGetWidth(self.frame) / _titles.count;
    
    for (NSInteger i = 0; i < _titles.count; i ++) {
        
        CHTLayoutButton *btn = [[CHTLayoutButton alloc]initWithFrame:CGRectMake(width * i, 0, width, CGRectGetHeight(self.frame)) subMargin:3 layoutButtonType:CHTLayoutButtonTypeRight];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_normalColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectColor forState:UIControlStateSelected];
        [btn setImage:_normalIcon forState:UIControlStateNormal];
        [btn setImage:_selectIcon forState:UIControlStateSelected];
        btn.tag = BUTTON_START_TAG + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    [self layoutLines];
    
    [self initItemDict];
}

- (void)setNormalIcon:(UIImage *)normalIcon{
    
    if (_normalIcon == normalIcon) {
        return;
    }
    _normalIcon = normalIcon;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[CHTLayoutButton class]]) {
            CHTLayoutButton *btn = (CHTLayoutButton *)view;
            [btn setImage:_normalIcon forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectIcon:(UIImage *)selectIcon{
    
    if (_selectIcon == selectIcon) {
        return;
    }
    _selectIcon = selectIcon;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[CHTLayoutButton class]]) {
            
            CHTLayoutButton *btn = (CHTLayoutButton *)view;
            [btn setImage:_selectIcon forState:UIControlStateSelected];
        }
    }
}

#pragma mark - event
- (void)btnClick:(CHTLayoutButton *)btn{
    
    _selectIndex = btn.tag - BUTTON_START_TAG;
    _selectBtn = btn;
    if (!btn.isSelected) {
        if (_delegate && [_delegate respondsToSelector:@selector(filterItemBar:didSelectButtonIndex:)]) {
            [_delegate filterItemBar:self didSelectButtonIndex:_selectIndex];
        }
    }else{
        
        [self reloadItemBar];
        
        [self hideContentView];
    }
}

- (void)reloadItemBar{
    
    //按钮的显示变更
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[CHTLayoutButton class]]) {
            
            CHTLayoutButton *btn = (CHTLayoutButton *)view;
            if (btn != _selectBtn) {
                btn.selected = NO;
            }
        }
    }
    _selectBtn.selected = !_selectBtn.selected;
    
    //按钮title修改
    NSString *key = [NSString stringWithFormat:@"CHT%ld",(long)_selectIndex];
    CHTFilterItem *item = [_itemDict objectForKey:key];
    [_selectBtn setTitle:item.desc forState:UIControlStateNormal];
    if ([item.desc isEqualToString:_titles[_selectIndex]]) {
        [_selectBtn setTitleColor:_normalColor forState:UIControlStateNormal];
    }else{
        [_selectBtn setTitleColor:_selectColor forState:UIControlStateNormal];
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
