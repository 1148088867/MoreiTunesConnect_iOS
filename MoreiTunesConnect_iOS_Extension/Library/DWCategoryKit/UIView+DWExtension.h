//
//  UIView+Extension.h
//  test
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DWExtension)

/** 截取某个view */
- (UIImage *)shotView;

/** 截图某个view的某块区域 */
- (UIImage *)shotViewWithScope:(CGRect)scope;

/** 绘制虚线
 *
 @  @param   lineFrame 虚线的 frame
 *  @param   length 虚线中短线的宽度
 *  @param   spacing 虚线中短线之间的间距
 *  @param   color  虚线中短线的颜色
 *
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;

@end
