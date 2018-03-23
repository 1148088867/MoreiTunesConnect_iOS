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

/** 设置请求头 */
#define MTCNetworkConfig [DWNetworking setConfigRequestType:DWRequestTypeJSON responseType:DWResponseTypeJSON];\
                         [DWNetworking setHttpHeaderConfig:@{@"Connection":@"keep-alive",\
                                    @"X-Apple-Widget-Key":@"e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42",\
                                    @"Content-Type":@"application/json",\
                                    @"Accept":@"application/json, text/javascript, */*; q=0.01",\
                                    @"X-Requested-With":@"XMLHttpRequest",\
                                    @"Referer":@"https://idmsa.apple.com/appleauth/auth/signin?widgetKey=e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42&widgetDomain=https://itunesconnect.apple.com:443&font=sf",\
                                    }];

#endif /* MTCOutPut_h */
