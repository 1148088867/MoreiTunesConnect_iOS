//
//  MTCOutPut.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef MTCOutPut_h
#define MTCOutPut_h

/** 日期格式 */
#define MTCTimeFormat @"YYYY-MM-dd HH:mm:ss"

/** 获取当前时间 */
#define MTCTime [NSDate dateCurrentTimeWithFormat:MTCTimeFormat]

/** 账号数据库名称 */
#define MTCACCOUNTDBNANE @"CoderDwangAccountDBName"

/** 账号数据库表名称 */
#define MTCACCOUNTTABLENAME @"CoderDwangAccountTableName"

/** 隐藏的App数据库名称 */
#define MTCNOTFOCUSDBNAME @"CoderDwangNotFocusDBName"

/** 隐藏的App数据库表名称 */
#define MTCNOTFOCUSTABLENAME @"CoderDwangNotFocusTableName"

/** GitHub */
#define MTCGitHub @"https://github.com/CoderDwang/MoreiTunesConnect_iOS"

/** 中国独立开发者项目列表 */
#define MTCIndependentDevelopersGitHub @"https://github.com/1c7/chinese-independent-developer"

/** QQ群 */
#define MTCQQGroup @"577506623"

/** 偏好设置 */
#define MTCUserDefaults [[NSUserDefaults alloc] initWithSuiteName:@"group.MoreiTunesConnect_iOS"]

/** 获取cooikes */
#define MTCCooikesData [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]]

/** 数据库操作单例 */
#define MTCSQL [MTCSqlManager sharedInstance]

/** 获取基础控制器 */
#define MTCBaseController(obj) ((MTCBaseViewController *)obj.viewController)

#endif /* MTCOutPut_h */
