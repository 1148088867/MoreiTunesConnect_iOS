//
//  MTCNotFocusModel.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCNotFocusModel : NSObject

/** app唯一标示 */
pcx(NSString, appid);

/** app名称 */
pcx(NSString, appName);

/** appLogo */
pcx(NSString, appIconUrl);

/** 关注时间 */
pcx(NSString, nfTime);

@end
