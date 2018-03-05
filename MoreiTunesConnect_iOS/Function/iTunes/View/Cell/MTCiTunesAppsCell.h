//
//  MTCiTunesAppsCell.h
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface MTCiTunesAppsCell : QMUITableViewCell

/** logo */
psx(UIImageView, icon);

/** 名称 */
psx(QMUILabel, name);

/** 最后操作时间 */
psx(QMUILabel, lastDate);

/** 状态(中文) */
psx(QMUILabel, statusLab);

/** 状态(颜色) */
psx(UIImageView, status);

/** 版本号 */
psx(QMUILabel, version);

@end
