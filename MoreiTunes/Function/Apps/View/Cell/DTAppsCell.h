//
//  DTAppsCell.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface DTAppsCell : QMUITableViewCell

/** logo */
psx(UIImageView, icon);

/** 名称 */
psx(QMUILabel, name);

/** 状态 */
psx(QMUILabel, status);

@end
