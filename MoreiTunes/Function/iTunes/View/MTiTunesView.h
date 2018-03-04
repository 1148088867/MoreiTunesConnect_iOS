//
//  MTiTunesView.h
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableView.h"
#import "MTiTunesAppsModel.h"

@interface MTiTunesView : QMUITableView

/** app信息数组 */
psx(NSArray<MTiTunesAppsModel *>, iTunesAppsArr);

@end
