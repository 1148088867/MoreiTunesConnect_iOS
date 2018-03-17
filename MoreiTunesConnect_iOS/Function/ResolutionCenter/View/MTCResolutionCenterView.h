//
//  MTCResolutionCenterView.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableView.h"
#import "MTCResolutionCenterModel.h"

@interface MTCResolutionCenterView : QMUITableView

/** 数据源 */
psx(NSArray<MTCResolutionCenterModel *>, resolutionCenterArr);

@end
