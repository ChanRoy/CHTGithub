//
//  CHTFilterConst.h
//  CHTGithub
//
//  Created by cht on 16/8/18.
//  Copyright © 2016年 cht. All rights reserved.
//

//#ifndef CHTFilterConst_h
//#define CHTFilterConst_h

typedef enum : NSUInteger {
    CHTFilterTypeDefault = 0,
    CHTFilterTypeTwoFloor,
    CHTFilterTypeCustomBar,
    CHTFilterTypeMutiSelect,
} CHTFilterType;

#define UIColorFromHex(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define CHTTINT_COLOR   UIColorFromHex(0XFF9933)

//#endif /* CHTFilterConst_h */
