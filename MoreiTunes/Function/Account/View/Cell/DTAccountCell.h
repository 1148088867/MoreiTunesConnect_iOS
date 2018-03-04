//
//  DTAccountCell.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/21.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface DTAccountCell : QMUITableViewCell

/** 账户邮箱 */
psx(QMUILabel, mail);

/** 备注 */
psx(QMUILabel, note);

/** 编辑时间 */
psx(QMUILabel, addTime);

@end
