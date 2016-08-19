//
//  QFHKEnumType.h
//  QFangWangHK
//
//  Created by cht on 16/1/19.
//  Copyright © 2016年 qfangwanghk. All rights reserved.
//

#ifndef QFangWang_QFHKEnumType_h
#define QFangWang_QFHKEnumType_h
#import <UIKit/UIKit.h>
////定義房源類型枚舉
typedef enum:NSInteger
{
    QFHKHouseNewHouse  = 0,
    QFHKHouseUsedHouse = 1,
    QFHKHouseRentHouse = 2,
    QFHKHouseEstateHouse = 3,
    QFHKHouseOwnerHouse = 4
    
}QFHKHouseType;

//业主放盘、放租
typedef enum : NSInteger {
    OwnerEntrustSale = 0,
    OwnerEntrustRent = 1,
} OwnerEntrustType;

////定义房源类型
//typedef enum : NSInteger {
//    QFHKHouseNewHouse = 0, //新盘
//    QFHKHouseUsedHouse,    //二手盘
//    QFHKHouseRentHouse,    //租盘
//    QFHKHouseEstatesHouse, //屋苑
//    QFHKHouseOwnerHouse    //业主放盘
//} QFHKHouseType;

//定義交通狀況或周邊配套
typedef enum : NSUInteger {
    
    QFHKTrafficType = 0,
    QFHKSurroundType,
    
} QFHKTrafficListType;

//定義篩選filterItem類型
typedef enum: NSInteger{
    
    QFHKFilterTypeRegion = 0,   //区域
    QFHKFilterTypeSalePrice,    //房价
    QFHKFliterTypeRentPrice,    //租金
    QFHKFilterTypeArea,         //面积
    QFHKFilterTypeBedRoom,      //间隔
    QFHKFilterTypeGardenAge,    //房龄
    QFHKFilterTypeRoomFloor,    //楼层
    QFHKFilterTypeDirection,    //坐向
    QFHKFilterTypeRoomLabel,    //亮点
    
} QFHKFilterType;

//网络专题枚举
typedef NS_ENUM(NSInteger, QFHKNetworkReachabilityStatus) {
    QFHKNetworkReachabilityStatusUnknown          = -1,
    QFHKNetworkReachabilityStatusNotReachable     = 0,
    QFHKNetworkReachabilityStatusReachableViaWWAN = 1,
    QFHKNetworkReachabilityStatusReachableViaWiFi = 2,
};

#endif /* QFHKEnumType_h */
