//
//  MTCKPView.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/21.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableView.h"
#import "MTCKPModel.h"

@interface MTCKPView : QMUITableView

/** headerView */
psx(QMUIFloatLayoutView, floatLayoutView);

/** app简介 */
pcx(NSString, des);

/** 此版本更新内容 */
pcx(NSString, releaseNote);

/** 预览图地址 */
psx(NSArray<NSString *>, imgLinks);

@end
