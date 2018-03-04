//
//  UIViewController+DWExtension.h
//  test
//
//  Created by Dwang on 2018/1/24.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DWExtension)

/** 是否使用baseView */
@property(nonatomic, assign, getter=isHasBaseView) BOOL hasBaseView;

/** 使用baseView替换系统view */
@property(nonatomic, strong) UIScrollView *baseView;

/** 设置导航栏透明 */
@property(nonatomic, assign, getter=isNavigationBarTransparent) BOOL navigationBarTransparent;

@end

