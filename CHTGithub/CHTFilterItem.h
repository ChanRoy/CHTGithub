//
//  CHTFilterItem.h
//  CHTGithub
//
//  Created by cht on 16/8/18.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHTFilterItem : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDesc:(NSString *)desc;

@end
