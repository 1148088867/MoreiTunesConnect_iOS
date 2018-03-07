//
//  MTCSpecialModel.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/7.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCSpecialModel : NSObject

/** app唯一标示 */
pcx(NSString, appid);

/** app名称 */
pcx(NSString, appName);

/** appLogo */
pcx(NSString, appIconUrl);

/** 关注时间 */
pcx(NSString, SPECIALTime);

/** 邮箱 */
pcx(NSString, email);

/** 密码 */
pcx(NSString, password);

/** Cookie */
psx(NSData, cookiesData);

@end
