//
//  MTCiTunesViewController.h
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseViewController.h"
#import "MTCAccountModel.h"

@interface MTCiTunesViewController : MTCBaseViewController

/** 账号信息 */
psx(MTCAccountModel, accountModel);

/** 更新账号中的cooike */
pblockx(void, updateCooikesData, MTCAccountModel *accountModel);

@end
