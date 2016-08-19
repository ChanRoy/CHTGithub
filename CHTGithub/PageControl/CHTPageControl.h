//
//  CHTPageControl.h
//  CHTGithub
//
//  Created by cht on 16/7/18.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHTPageControl;

@protocol CHTPageControlDelegate <NSObject>

@optional
- (void)pageControl:(CHTPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;

@end


@interface CHTPageControl : UIControl

@property (nonatomic, strong) Class dotViewClass;

@property (nonatomic, strong) UIImage *dotImage;

@property (nonatomic, strong) UIImage *currentDotImage;

@property (nonatomic, assign) CGSize dotSize;

@property (nonatomic, strong) UIColor *dotColor;

@property (nonatomic, assign) NSInteger spacingBetweenDots;

@property (nonatomic, assign) id<CHTPageControlDelegate> delegate;

@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) BOOL hidesForSinglePage;

@property (nonatomic, assign) BOOL shouldResizeFromCenter;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;


@end
