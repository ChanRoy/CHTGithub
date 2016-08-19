//
//  CHTFilterItemBar.h
//  CHTGithub
//
//  Created by cht on 16/8/17.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTFilterConst.h"
#import "CHTFilterItem.h"

@class CHTFilterItemBar;

@protocol CHTFilterItemBarDelegate <NSObject>

@optional
- (void)filterItemBar:(CHTFilterItemBar *)filterItemBar didSelectButtonIndex:(NSInteger)buttonIndex;

- (void)filterItemBar:(CHTFilterItemBar *)filterItemBar didSelectFilterItem:(CHTFilterItem *)filterItem;

- (NSArray *)dataSourceOfFilterItemBar:(CHTFilterItemBar *)filterItemBar didSelectButtonIndex:(NSInteger)buttonIndex;

@required
- (NSArray <NSNumber *> *)filterTypeOfFilterItemBar:(CHTFilterItemBar *)filterItemBar;



@end


@interface CHTFilterItemBar : UIControl

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIImage *normalIcon;

@property (nonatomic, strong) UIImage *selectIcon;

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIColor *selectColor;

@property (nonatomic, assign) id <CHTFilterItemBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)parentView;

- (void)showContentView;

- (void)hideContentView;

@end
