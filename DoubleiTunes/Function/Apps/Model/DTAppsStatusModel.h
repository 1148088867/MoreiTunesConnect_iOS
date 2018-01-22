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
@property(nonatomic, copy) NSString *appName;

/** app 状态 */
@property(nonatomic, copy) NSString *appStatus;

/** app logo */
@property(nonatomic, copy) NSString *appIcon;

@end
