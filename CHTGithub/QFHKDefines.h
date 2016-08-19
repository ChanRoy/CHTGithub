//
//  QFHKDefines.h
//  QFangWangHK
//
//  Created by QFWangLP on 2016/1/12.
//  Copyright © 2016年 qfangwanghk. All rights reserved.
//

#ifndef QFHKDefines_h
#define QFHKDefines_h

/**
 *  常用宏定義
 */
/* ****************************************************************************************************************** */

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//隨機顏色
#define RandomColor [UIColor colorWithRed:(random() % 256 / 255.0f) green:(random() % 256 / 255.0f) blue:(random() % 256 / 255.0f) alpha:1]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width
#define App_Delegate            [UIApplication sharedApplication].delegate
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define QFHKScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define QFHKScreenHeight        [[UIScreen mainScreen] bounds].size.height

// 系统控件默认高度
#define kStatusBarHeight        (20.f)

#define kTopBarHeight           (44.f)
#define kBottomBarHeight        (49.f)

#define kCellDefaultHeight      (44.f)

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

#define kNavigationBarHeight    (64.0f)

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

//快捷设置图片
#define QFHKSetImage(imageName) [UIImage imageNamed:imageName]
//APP聊天框颜色 用于标记等
#define QFHKThemeColor [UIColor colorWithRed:247.0 / 255.0 green:186.0 / 255.0 blue:26.0 / 255.0 alpha:1]
//灰色文本内容
#define QF_TEXT_GRAY_COLOR [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1]

//APP 用于Bar及一些背景--主题黑
#define QFHKThemeBarColor [UIColor colorWithRed:40.0 / 255.0 green:40.0 / 255.0 blue:47.0 / 255.0 alpha:1]

#define QFHKTextFont(fontSize) [UIFont systemFontOfSize:fontSize]


#define QFHKBaseUrl @"http://hk.qfang.com/qfang-api/mobile"
//#define QFHKBaseUrl @"http://172.16.72.40/qfang-api/mobile" //接口本地开发笃辉本地机ip
//#define QFHKBaseUrl @"http://10.251.92.31/qfang-api/mobile"
//#define QFHKBaseUrl @"http://10.153.146.210/qfang-api/mobile"
//#define QFHKBaseUrl @"http://10.251.92.25/qfang-api/mobile" //预发布服务器ip

#define QFHKCalculatorBaseUrl @"http://hkapi.qfang.com"
//#define QFHKCalculatorBaseUrl @"http://192.168.0.245" //按揭計算機主域名
//#define QFHKCalculatorBaseUrl @"http://00852.testerp.qfang.com" //按揭计算机预发布

#define MortgageCalculateIndex @"/qfang-api/taxController/mortgageCalculateIndex"
#define CalculateMortgage @"/qfang-api/taxController/calculateMortgage"

#define QFHKGMSNearbyBaseUrl @"https://maps.googleapis.com/maps/api/place/nearbysearch/json" //谷歌地图周边信息

/******************key***********************/
#ifndef __OPTIMIZE__
#define QFHKGMSKey      @"AIzaSyBdxqRN7thU4aqPAT5JqfesxkP6S71BqzM" //谷歌地图调试时使用
#define QFHKGAITrackId  @"UA-80668620-1"                           //谷歌分析调试时使用
#else
#define QFHKGMSKey      @"AIzaSyCH3MEMNePOC47BY69eSijJ9qc2kkvR_Cw" //谷歌地图正式环境
#define QFHKGAITrackId  @"UA-76794933-1"                           //谷歌分析正式环境
#endif

#define QFHKGMSWebKey @"AIzaSyDBo648MIo7JSk-3BuaqOHE4KaHEppMdYA" //周边的

/***********************************************图片显示尺寸宏****************************************************************/
#define QFHK_PICTURE_100_135(pictureUrlStr) \
[pictureUrlStr stringByReplacingOccurrencesOfString:@"{size}" withString:@"100x135"]

#define QFHK_PICTURE_180_135(pictureUrlStr) \
[pictureUrlStr stringByReplacingOccurrencesOfString:@"{size}" withString:@"180x135"]

#define QFHK_PICTURE_386_289(pictureUrlStr) \
[pictureUrlStr stringByReplacingOccurrencesOfString:@"{size}" withString:@"386x289"]

#define QFHK_PICTURE_600_450(pictureUrlStr) \
[pictureUrlStr stringByReplacingOccurrencesOfString:@"{size}" withString:@"600x450"]

#define QFHK_PICTURE_800_600(pictureUrlStr) \
[pictureUrlStr stringByReplacingOccurrencesOfString:@"{size}" withString:@"800x600"]

/* ****************************************************************************************************************** */
//打印位置的 NSLog
//release 状态下禁用nslog 及 qfhklog
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#define QFHKLog(format, ...) do {                                                                     \
fprintf(stderr, "<%s : %d> %s\n",                                                               \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],                      \
__LINE__, __func__);                                                                            \
(NSLog)((format), ##__VA_ARGS__);                                                               \
fprintf(stderr, "-----------------------------------------------------------------------\n");   \
} while (0)
#else
#define NSLog(...)
#define QFHKLog(...)
#endif

/* ****************************************************************************************************************** */

#define W(num)    QFHKScreenWidth * (num) / 320


// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
#define CENTER_X(v)             (v).center.x
#define CENTER_Y(v)             (v).center.y

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


//网络请求的缓存时间
#define QF_CACHED_TIME_OFF       (-1.f)
#define QF_CACHED_TIME_SHORT     (1.f)
#define QF_CACHED_TIME_MIDDLE    (60.f * 60.f)
#define QF_CACHED_TIME_LONG      (24.f * 60.f * 60.f)
#define QF_CACHED_TIME_ALWAYS    (365.f * 24.f * 60.f * 60.f)



//用来消除一些地方调用performSelector方法的警告
#define QFHKSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


//网络请求状态枚举

//网络请求标志位，1表示成功，0表示失败
#define REQUEST_STATUS_KEY      @"flag"
//返回的错误信息
#define REQUEST_STATUS_MSG      @"msg"
//返回数据
#define REQUEST_STATUS_DATA     @"data"
#define REQUEST_STATUS_LIST     @"list"
//数据请求成功
#define REQUEST_STATUS_SUCCESS  1
//数据请求失败
#define REQUEST_STATUS_FAIL     0

//提示框显示时间
#define DisplayDurationOfHUD    2.0f

//NSLog优化
/* ****************************************************************************************************************** */
#pragma mark - Log Method (宏 LOG)
//__FILE__ 当前的类名， __PRETTY_FUNCTION__ 当前的函数名  __LINE__当前的行数
//打印位置
#define LCLogLocation() do {NSLog(@"File: %s \nFunc: %s \nLine: %u\n", __FILE__, __PRETTY_FUNCTION__, __LINE__);} while(0)

//打印错误
#define LCLogError() do { NSLog(@"Error Occured!\n"); LCLogLocation(); } while (0)

//判断字符串是否为空
#define IS_STRING(string) (string != nil && ![string isKindOfClass:[NSNull class]] && ![string isEqualToString:@""])

//房源类型占位符文案
#define kQFHKNewHousePlaceholderText    @"請輸入新盤名稱或地址關鍵字"
#define kQFHKUsedHousePlaceholderText   @"請輸入屋苑名或地址關鍵字"
#define kQFHKRentHousePlaceholderText   @"請輸入屋苑名或地址關鍵字"
#define kQFHKEstateHousePlaceholderText @"請輸入屋苑名或地址關鍵字"

//黑色文本颜色
#define QF_TEXT_BLACK_COLOR [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]
//暗色文本内容
#define QF_TEXT_DARK_COLOR [UIColor colorWithRed:136 / 255.0 green:136 / 255.0 blue:136 / 255.0 alpha:1]
//灰色文本内容
#define QF_TEXT_GRAY_COLOR [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1]
//背景亮色
#define QF_BACKGROUND_LIGHT_COLOR [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1]
//背景灰色
#define QF_BACKGROUND_GRAY_COLOR [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1]
//背景暗色
#define QF_BACKGROUND_DARK_COLOR [UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1]

#define QF_BACKGROUND_CELL_SELECTED_COLOR [UIColor colorWithRed:244.0 / 255.0 green:244.0 / 255.0 blue:244.0 / 255.0 alpha:1]

#define QF_SEPERAT_LINE_COLOR [UIColor colorWithRed:229.f / 255.0 green:229.f / 255.0 blue:229.f / 255.0 alpha:1]


//网络连接状态
#define QFHK_NET_CONNECTED        [QFHKConfig isNetConnected]
#define QFHK_WIFI_CONNECTED       [QFHKConfig isReachableViaWiFi]

#define QFHK_NETWORK_STATUS       [[QFHKConfig sharedInstance] qfhknetworkReachabilityStatus]

#define QFHK_VALIDATE_REQUEST(json) \
([json isKindOfClass:[NSDictionary class]] && [json[REQUEST_STATUS_KEY] integerValue] == REQUEST_STATUS_SUCCESS)

//获取Q房网HK App在AppStore最新版本的URL地址
#define QFHK_APP_URL @"http://itunes.apple.com/lookup?id=1105338128"

// App Name
#define AppDisplayName          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define VERSION_APP_DISPLAY     [[[NSBundle mainBundle] infoDictionary] \
objectForKey:@"CFBundleShortVersionString"]

/* ****************************************************************************************************************** */
#endif /* QFHKDefines_h */
