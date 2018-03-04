//
//  UIImage+Extenison.h
//  test
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DWExtension)

/** 滤镜类型 */
typedef NS_ENUM(NSUInteger, DWFilterType) {
    DWFilterTypeInstant = 0,//怀旧
    DWFilterTypeNoir,//黑白
    DWFilterTypeTonal,//色调
    DWFilterTypeTransfer,//岁月
    DWFilterTypeMono,//单色
    DWFilterTypeFade,//褪色
    DWFilterTypeProcess,//冲印
    DWFilterTypeChrome,//铬黄
};

/** 模糊类型 */
typedef NS_ENUM(NSUInteger, DWBlurType) {
    DWBlurTypeGaussianBlur = 0,//高斯模糊
    DWBlurTypeBoxBlur,//均值模糊(Available in iOS 9.0 and later)
    DWBlurTypeDiscBlur,//环形卷积模糊(Available in iOS 9.0 and later)
    DWBlurTypeMedianFilter,//中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
    DWBlurTypeMotionBlur,//运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
};

/** 生成圆角 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/** 对图片进行滤镜处理 */
- (UIImage *)imageOriginalWithFilterType:(DWFilterType)filterType;

/** 对图片进行模糊处理
 *  @param   blurType 模糊类型
 *  @param   radius   模糊度
*/
- (UIImage *)imageOriginalWithBlurType:(DWBlurType)blurType radius:(NSInteger)radius;

/**
*  调整图片饱和度, 亮度, 对比度
*
*  @param saturation 饱和度
*  @param brightness 亮度: -1.0 ~ 1.0
*  @param contrast   对比度
*
*/
- (UIImage *)imageOriginalWithsaturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;

@end
