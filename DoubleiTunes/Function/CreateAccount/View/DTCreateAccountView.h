//
//  DTCreateAccountView.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface DTCreateAccountView : QMUITableView

/** 当为编辑账号信息时有值 */
@property(nonatomic, strong) NSArray<NSString *> *infos;

@end
