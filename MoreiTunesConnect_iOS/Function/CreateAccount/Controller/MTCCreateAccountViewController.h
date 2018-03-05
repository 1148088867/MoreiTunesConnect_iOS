//
//  MTCCreateAccountViewController.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseViewController.h"

@interface MTCCreateAccountViewController : MTCBaseViewController

/** 当编辑时此参数有值 */
psx(MTCAccountModel, accountModel);

/** 添加/编辑账户成功 */
pblockx(void, createAccountSuccess, MTCAccountModel *accountModel);

@end
