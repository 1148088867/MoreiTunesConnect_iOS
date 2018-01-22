//
//  DTOutPut.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef DTOutPut_h
#define DTOutPut_h

/** 账号数据库名称 */
#define DTAccountDBName @"CoderDwangAccountDBName"

/** 数据库表名称 */
#define DTAccountTableName @"CoderDwangAccountTableName"

/** iTunes登录界面 */
#define DTiTunesLogin @"https://idmsa.apple.com/IDMSWebAuth/login?appIdKey=891bd3417a7776362562d2197f89480a8547b108fd934911bcbea0110d07f757&path=%2Faccount%2F&rv=1"

/** iTunes登录成功界面 */
#define DTiTunesLoginSuccess @"https://developer.apple.com/account/#/welcome"

/** iTunesApp界面 */
#define DTiTunesApps @"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app"

/** 数据库操作单例 */
#define DTSQL [DTSqlManager sharedInstance]

#endif /* DTOutPut_h */
