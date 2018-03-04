//
//  MTBaseViewController.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface MTBaseViewController : QMUICommonViewController

/** 进度指示器 */
@property(nonatomic, strong) MBProgressHUD *progressHUD;

/** 关闭进度指示器 */
- (void)dismissProgressHUD;

/** 设置导航视图透明 */
- (void)setNavigationBarTransparence;

@end
