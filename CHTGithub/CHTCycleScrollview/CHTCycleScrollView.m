//
//  CHTCycleScrollView.m
//  CHTGithub
//
//  Created by cht on 16/7/19.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTCycleScrollView.h"
#import "UIImageView+WebCache.h"


#define VIEW_WIDTH  CGRectGetWidth(self.frame)
#define VIEW_HEIGHT CGRectGetHeight(self.frame)
#define START_TAG   100

static BOOL     const kDefaultAutoScroll = YES;
static BOOL     const kDefaultShowPageControl = YES;
static CGFloat  const kDefaultScollTimeInterval = 1.0f;

typedef enum : NSUInteger {
    
    CHTImageTypeLocal   = 0,
    CHTImageTypeFromNet = 1,
} CHTImageType;

@interface CHTCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation CHTCycleScrollView{
    
    NSMutableArray<UIImageView *> *_imageViews;
    UIImage *_placeholderImage;
    CHTImageType _imageType;
    NSInteger _imageCount;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageType = CHTImageTypeLocal;
        _imageCount = images.count;
        _images = images;
        
        [self initialization];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls placeholderImage:(UIImage *)placeholderImage{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageType = CHTImageTypeFromNet;
        _imageCount = imageUrls.count;
        _placeholderImage = placeholderImage;
        _imageUrls = imageUrls;
        
        [self initialization];
    }
    return self;
}

#pragma mark - Setters

- (void)setImageUrls:(NSArray *)imageUrls{
    
    if (_imageUrls == imageUrls) {
        return;
    }
    _imageUrls = imageUrls;
    
    _imageType = CHTImageTypeFromNet;
    _imageCount = imageUrls.count;
    
    [self initialization];
}

- (void)setImages:(NSArray *)images{
    
    if (_images == images) {
        return;
    }
    _images = images;
    _imageType = CHTImageTypeLocal;
    _imageCount = images.count;
    
    [self initialization];
}

- (void)setAutoScroll:(BOOL)autoScroll{
    
    if (_autoScroll == autoScroll) {
        return;
    }
    _autoScroll = autoScroll;
    [self stopTimer];
    [self startTimer];
}

- (void)setShowPageControl:(BOOL)showPageControl{
    
    if (_showPageControl == showPageControl) {
        return;
    }
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
}

- (void)setAutoScollTimeInterval:(CGFloat)autoScollTimeInterval{
    
    if (_autoScollTimeInterval == autoScollTimeInterval) {
        return;
    }
    _autoScollTimeInterval = autoScollTimeInterval;
    [self stopTimer];
    [self startTimer];
}

#pragma mark - UI
- (void)configUI{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _scrollView.contentSize =CGSizeMake(VIEW_WIDTH * 3, VIEW_HEIGHT);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _imageViews = [NSMutableArray new];
    
    //setup three imageViews in the _scrollView
    for (NSInteger i = 0; i < 3; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(VIEW_WIDTH * i, 0, VIEW_WIDTH, VIEW_HEIGHT);
        
        NSInteger index = 0;
        if (i == 0) index = _imageCount - 1;
        if (i == 1) index = 0;
        if (i == 2) index = 1;
        
        imageView.tag = index + START_TAG;
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
        [imageView addGestureRecognizer:tap];
        
        [self setimageView:imageView atIndex:index];
        [_imageViews addObject:imageView];
        [_scrollView addSubview:imageView];
    }
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT - 30, VIEW_WIDTH, 30)];
    _pageControl.numberOfPages = _imageCount;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
}

#pragma mark - action

- (void)tapEvent:(UITapGestureRecognizer *)tap{
    
    if (_delegate) {
        
        [_delegate cycleScrollView:self didSelectItemAtIndex:tap.view.tag - START_TAG];
    }
}

- (void)initialization{
    
    _autoScroll             = kDefaultAutoScroll;
    _showPageControl        = kDefaultShowPageControl;
    _autoScollTimeInterval  = kDefaultScollTimeInterval;
    
    [self configUI];
    
    [self startTimer];
}

- (void)setimageView:(UIImageView *)imageView atIndex:(NSInteger)index{
    
    if (_imageType == CHTImageTypeLocal) {
        
        UIImage *image = _images[index];
        imageView.image = image;
    }
    else{

        NSURL *url = [NSURL URLWithString:_imageUrls[index]];
        [imageView sd_setImageWithURL:url placeholderImage:_placeholderImage];
    }
    
}

- (void)updateUI{
    
    int flag = 0;
    //slide to right
    if (_scrollView.contentOffset.x > VIEW_WIDTH) {
        flag = 1;
    }
    //slide to left
    else if (_scrollView.contentOffset.x == 0){
        flag = -1;
    }
    //no moving
    else{
        return;
    }
    
    //change the image in imageViews
    for (UIImageView *imageView in _imageViews) {
        
        NSInteger index = imageView.tag - START_TAG + flag;
                
        if (index < 0) {
            index = _imageCount - 1;
        }else if (index >= _imageCount){
            index = 0;
        }
        
        imageView.tag = index + START_TAG;
            
        [self setimageView:imageView atIndex:index];
            
        //the imageView in the middel should be always in the middle
        self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
        
        
    }
    _pageControl.currentPage = _imageViews[1].tag - START_TAG;
    
    if (_delegate) {
        
        [_delegate cycleScrollView:self didScrollToIndex:_imageViews[1].tag - START_TAG];
    }
}

#pragma mark - timer
- (void)startTimer{
    
    if (_autoScroll) {
        
        if (_timer) {
            [self stopTimer];
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScollTimeInterval target:self selector:@selector(timerRefresh) userInfo:nil repeats:YES];
        
        //timer add to runLoop
        //NSRunLoopCommonModes: timer will not stop when scrollView is scrolling
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer{
    
    if (_timer) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)timerRefresh{
    
    //the normal contentOffset is (VIEW_WIDTH, 0), set the x of contentOffset to (VIEW_WIDTH * 2) means slide to left for one page.
    [_scrollView setContentOffset:CGPointMake(VIEW_WIDTH * 2, 0) animated:YES];
}

#pragma mark - scrollview delegate

//when user drags the scrollView, the two methods below will be called. (by user)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
}
//(by user)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self startTimer];
}

//when scrollView end decelerating, this method wiil be called. (by user)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self updateUI];
}

//when call 'setContentOffset', this method will be called. (by system)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self updateUI];
}


@end
