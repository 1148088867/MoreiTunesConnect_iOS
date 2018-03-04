//
//  Color.h
//  test
//
//  Created by Dwang on 2018/2/24.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Color_h
#define Color_h

/** 设置RGBA色彩 */
#define UIColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.00 green:g/255.00 blue:b/255.00 alpha:a]

/** 设置RGB色彩 */
#define UIColorMakeRGB(r, g, b) [UIColor colorWithRed:r/255.00 green:g/255.00 blue:b/255.00 alpha:1.0]

/** 16进制<UIColorHEX(0x1874de)> */
#define UIColorHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]

/** 随机颜色 */
#define UIColorRandom UIColorWithRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* Color_h */
