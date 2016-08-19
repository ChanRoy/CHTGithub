//
//  CHTFilterContentView.h
//  CHTGithub
//
//  Created by cht on 16/8/17.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTFilterConst.h"
@class CHTFilterItem;

@interface CHTFilterContentView : UIControl

@property (nonatomic, copy) void(^hideBlock)();

@property (nonatomic, copy) void(^didSelectFilterItem)(CHTFilterItem *);

- (instancetype)initWithFrame:(CGRect)frame filterType:(CHTFilterType)filterType dataSource:(NSArray *)dataSource;

@end
