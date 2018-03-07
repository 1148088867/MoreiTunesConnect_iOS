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

/** 账号数据库名称 */
#define MTCAccountDBName @"CoderDwangAccountDBName"

/** 数据库表名称 */
#define MTCAccountTableName @"CoderDwangAccountTableName"

/** iTunes登录 */
#define MTCiTunesLogin @"https://idmsa.apple.com/appleauth/auth/signin"

/** iTunesApps */
#define MTCiTunesApps @"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/manageyourapps/summary/v2"

/** GitHub */
#define MTCGitHub @"https://github.com/CoderDwang/MoreiTunesConnect_iOS"

/** QQ群 */
#define MTCQQGroup @"577506623"

/** 偏好设置 */
#define MTCUserDefaults [[NSUserDefaults alloc] initWithSuiteName:@"group.MoreiTunesConnect_iOS"]

/** 获取cooikes */
#define MTCCooikes [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:MTCiTunesLogin]]

/** 数据库操作单例 */
#define MTCSQL [MTCSqlManager sharedInstance]

#endif /* MTCOutPut_h */
