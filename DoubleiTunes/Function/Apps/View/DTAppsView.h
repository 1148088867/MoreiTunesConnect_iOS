//
//  DTAppsView.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
@class DTAppsStatusModel;

@interface DTAppsView : QMUITableView

/** 数据源 */
@property(nonatomic, strong) NSArray<DTAppsStatusModel *> *appsArr;

@end
