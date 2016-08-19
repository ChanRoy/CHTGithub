//
//  CHTCycleScrollView.h
//  CHTGithub
//
//  Created by cht on 16/7/19.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHTCycleScrollView;

@protocol CHTCycleScrollViewDelegate <NSObject>

@optional

- (void)cycleScrollView:(CHTCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

- (void)cycleScrollView:(CHTCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end

/**
 *  cycle photos with three imageViews
 */
@interface CHTCycleScrollView : UIView

@property (nonatomic, assign) BOOL autoScroll;

@property (nonatomic, assign) BOOL showPageControl;

@property (nonatomic, assign) CGFloat autoScollTimeInterval;

@property (nonatomic, strong) NSArray *imageUrls;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) id<CHTCycleScrollViewDelegate> delegate;

/**
 *  init method
 *
 *  @param frame            frame
 *  @param images           images array to display
 *
 *  @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

/**
 *  init method
 *
 *  @param frame            frame
 *  @param imageUrls        imageUrls array to display
 *  @param placeholderImage placeholderImage
 *
 *  @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls placeholderImage:(UIImage *)placeholderImage;

/**
 *  this method should be called when the viewController 'will disappear', or it may cause leak.
 */
- (void)stopTimer;

@end
