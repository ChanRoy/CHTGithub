//
//  CHTFilterItem.m
//  CHTGithub
//
//  Created by cht on 16/8/18.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTFilterItem.h"

@implementation CHTFilterItem

- (instancetype)initWithDesc:(NSString *)desc
{
    self = [super init];
    if (self) {
        _desc = desc;
    }
    return self;
}

@end
