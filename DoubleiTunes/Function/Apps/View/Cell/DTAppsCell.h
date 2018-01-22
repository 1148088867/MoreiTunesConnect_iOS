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
@property(nonatomic, strong) UIImageView *icon;

/** 名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 状态 */
@property(nonatomic, strong)  QMUILabel *status;

@end
