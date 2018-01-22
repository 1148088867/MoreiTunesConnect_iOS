//
//  DTAccountView.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface DTAccountView : QMUITableView

/** 账号模型数据源 */
@property(nonatomic, strong) NSMutableArray<DTAccountModel *> *accountModelArrM;

@end
