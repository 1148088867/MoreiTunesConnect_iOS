//
//  DTCreateAccountViewController.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTBaseViewController.h"

@interface DTCreateAccountViewController : DTBaseViewController

/** 当编辑时此参数有值 */
psx(DTAccountModel, accountModel);

/** 添加/编辑账户成功 */
pblockx(void, createAccountSuccess, DTAccountModel *accountModel);

@end
