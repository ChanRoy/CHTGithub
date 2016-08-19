//
//  CHTAnimatedDotView.m
//  CHTGithub
//
//  Created by cht on 16/7/18.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation CHTAnimatedDotView

#pragma mark - init
- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    _dotColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.layer.borderWidth  = 2;
}

- (void)changeActivityState:(BOOL)active{
    
    if (active) {
        [self animateToActiveState];
    }else{
        [self animatieToDeactiveState];
    }
}

- (void)animateToActiveState{
    
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.backgroundColor = _dotColor;
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
    } completion:nil];
}

- (void)animatieToDeactiveState{
    
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}

#pragma mark - set method
- (void)setDotColor:(UIColor *)dotColor{
    
    _dotColor = dotColor;
    self.layer.borderColor = dotColor.CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
