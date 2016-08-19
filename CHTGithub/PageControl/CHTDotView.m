//
//  CHTDotView.m
//  CHTGithub
//
//  Created by cht on 16/7/18.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTDotView.h"

@implementation CHTDotView

- (instancetype)init{
    
    if (self = [super init]) {
        [self initialzation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initialzation];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialzation];
    }
    return self;
}

- (void)initialzation{
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.layer.borderWidth  = 2;
}

- (void)changeActivityState:(BOOL)active{
    
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
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
