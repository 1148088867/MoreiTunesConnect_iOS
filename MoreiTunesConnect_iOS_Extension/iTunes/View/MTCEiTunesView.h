//
//  MTCiTunesView.h
//  MoreiTunesConnect_iOS_Extension
//
//  Created by Dwang on 2018/3/7.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCEiTunesView : UIView

/** logo */
psx(UIImageView, icon);

/** 名称 */
psx(UILabel, name);

/** 最后操作时间 */
psx(UILabel, lastDate);

/** 状态(中文) */
psx(UILabel, statusLab);

/** 状态(颜色) */
psx(UIImageView, status);

/** 版本号 */
psx(UILabel, version);

@end
