//
//  ViewController.m
//  CHTGithub
//
//  Created by cht on 16/7/15.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "CHTFilterItemBar.h"
#import "CHTFilterItem.h"
#import "AFNetworking.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  http://hk.qfang.com/qfang-api/mobile/common/query/querySalePriceCondition
 *  http://hk.qfang.com/qfang-api/mobile/business/package/getLevelTwoAreaTree
 *  http://hk.qfang.com/qfang-api/mobile/business/package/queryMergedMoreParam
 */

@interface ViewController ()<CHTFilterItemBarDelegate>

@property (nonatomic, strong) NSMutableArray *prices;
@property (nonatomic, strong) NSMutableArray *ages;

@property (nonatomic, strong) CHTFilterItemBar *filterBar;

@end


@implementation ViewController{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _filterBar = [[CHTFilterItemBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49) parentView:self.view];
    _filterBar.titles = @[@"区域", @"价格", @"间隔", @"更多"];
    _filterBar.normalIcon = [UIImage imageNamed:@"cht_btn_no"];
    _filterBar.selectIcon = [UIImage imageNamed:@"cht_btn_sl"];
    _filterBar.delegate = self;
}



- (void)requestPriceData{
    
    _prices = [NSMutableArray new];
    
    [[AFHTTPSessionManager manager]GET:@"http://hk.qfang.com/qfang-api/mobile/common/query/querySalePriceCondition" parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        if ([dict[@"flag"] isEqualToString:@"1"]) {
            
            NSArray *arr = dict[@"data"][@"list"];
            for (NSDictionary *dic in arr) {
                
                CHTFilterItem *item = [[CHTFilterItem alloc]initWithDesc:dic[@"desc"]];
                [_prices addObject:item];
                
            }
        }
        [self.filterBar showContentView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error.description);
        
    }];
    
}

- (void)requestAgeData{
    
    _ages = [NSMutableArray new];
    [[AFHTTPSessionManager manager]GET:@"http://hk.qfang.com/qfang-api/mobile/common/query/queryGardenAgeCondition" parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        if ([dict[@"flag"] isEqualToString:@"1"]) {
            
            NSArray *arr = dict[@"data"][@"list"];
            for (NSDictionary *dic in arr) {
                
                CHTFilterItem *item = [[CHTFilterItem alloc]initWithDesc:dic[@"desc"]];
                [_ages addObject:item];
                
            }
        }
        [self.filterBar showContentView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.description);
    }];
}

#pragma mark - delegate
- (NSArray <NSNumber *> *)filterTypeOfFilterItemBar:(CHTFilterItemBar *)filterItemBar{
    
    return @[@(CHTFilterTypeDefault),@(CHTFilterTypeDefault),@(CHTFilterTypeDefault),@(CHTFilterTypeDefault)];
}

- (void)filterItemBar:(CHTFilterItemBar *)filterItemBar didSelectButtonIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:{
            [self requestPriceData];
        }
            break;
        case 1:{
            [self requestAgeData];
        }
            break;
        case 2:{
            [self requestPriceData];
        }
            break;
        case 3:{
            [self requestAgeData];
        }
            break;
        default:
            break;
    }
    
    
}

- (NSArray *)dataSourceOfFilterItemBar:(CHTFilterItemBar *)filterItemBar didSelectButtonIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            return _prices;
            break;
        case 1:
            return _ages;
            break;
        case 2:
            return _prices;
            break;
        case 3:
            return _ages;
            break;
        default:
            break;
    }
    return nil;
}

- (void)filterItemBar:(CHTFilterItemBar *)filterItemBar didSelectFilterItem:(CHTFilterItem *)filterItem{
    
    
    NSLog(@"%@",filterItem.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
