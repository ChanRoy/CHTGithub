//
//  CHTAbstractDotView.m
//  CHTGithub
//
//  Created by cht on 16/7/18.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTAbstractDotView.h"

@implementation CHTAbstractDotView

- (instancetype)init{
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in %@",NSStringFromSelector(_cmd),self.class] userInfo:nil];
}

- (void)changeActivityState:(BOOL)active{
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in %@",NSStringFromSelector(_cmd),self.class] userInfo:nil];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
