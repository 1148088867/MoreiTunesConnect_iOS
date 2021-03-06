//
//  MTCBaseViewController.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface MTCBaseViewController : QMUICommonViewController

/** 活动指示器 */
psx(QMUITips, progressHUD);

/** 关闭活动指示器 */
- (void)dismissProgressHUD;

/** 显示系统分享组件 */
- (void)showActivityViewControllerWithItems:(NSArray *)activityItems obj:(id)obj;

/** 设置push动画 */
- (void)setAnimatedWithTransitionType:(NSString *)type;

@end
