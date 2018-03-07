//
//  MTCAccountModel.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCAccountModel : NSObject

/** Apple ID邮箱📮 */
pcx(NSString, mail);

/** 密码(本地存储使用aes加密)🐱 */
pcx(NSString, password);

/** 备注📒 */
pcx(NSString, note);

/** 编辑账号时间⌚️ */
pcx(NSString, addTime);

/** Cookie(记录登录成功后的cooike，减少请求login接口的次数，节约查询时间，生命周期为app的一次使用周期) */
psx(NSData, cookiesData);

@end
