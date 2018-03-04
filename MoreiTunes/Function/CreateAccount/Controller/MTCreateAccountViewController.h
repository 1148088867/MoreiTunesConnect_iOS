//
//  MTCreateAccountViewController.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTBaseViewController.h"

@interface MTCreateAccountViewController : MTBaseViewController

/** 当编辑时此参数有值 */
psx(MTAccountModel, accountModel);

/** 添加/编辑账户成功 */
pblockx(void, createAccountSuccess, MTAccountModel *accountModel);

@end
