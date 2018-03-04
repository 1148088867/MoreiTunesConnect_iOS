//
//  DTAppsStatusModel.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTAppsStatusModel : NSObject

/** app 名称 */
pcx(NSString, appName);

/** app 状态 */
pcx(NSString, appStatus);

/** app logo */
pcx(NSString, appIcon);

@end
