//
//  MTCStatusModel.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/4/2.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTCStatusPlatformsModel;
@class MTCStatusVersionModel;

@interface MTCStatusModel : NSObject

/** 商店地址 */
pcx(NSString, appStoreUrl);

/** appid */
pcx(NSString, adamId);

/** 版本信息 */
pcx(NSArray<MTCStatusPlatformsModel *>, platforms);

@end

@interface MTCStatusPlatformsModel : NSObject

/** 在销售的版本 */
psx(MTCStatusVersionModel, deliverableVersion);

/** 在审核的版本 */
psx(MTCStatusVersionModel, inFlightVersion);

@end

@interface MTCStatusVersionModel : NSObject

/** 问题数 */
pax(NSInteger, issuesCount);

/** 版本id */
pcx(NSString, versionID);

/** 版本 */
pcx(NSString, version);

/** 状态 */
pcx(NSString, state);

/** 状态对应中文 */
pcx(NSString, stateStr);

@end
