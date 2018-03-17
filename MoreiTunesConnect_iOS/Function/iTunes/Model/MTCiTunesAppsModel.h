//
//  MTCiTunesAppsModel.h
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTCiTunesAppVersionModel;
@class MTCiTunesAppDeliverableVersion;
@class MTCiTunesAppInFlightVersion;

@interface MTCiTunesAppsModel : NSObject

/** Apple ID */
pcx(NSString, adamId);

/** Name */
pcx(NSString, name);

/** SKU */
pcx(NSString, vendorId);

/** 套装 ID */
pcx(NSString, bundleId);

/** logo */
pcx(NSString, iconUrl);

/** 最后修改日期 */
pcx(NSString, lastModifiedDate);

psx(NSArray<MTCiTunesAppVersionModel *>, versionSets);

@end

@interface MTCiTunesAppVersionModel : NSObject

/** 在销售版本 */
psx(MTCiTunesAppDeliverableVersion, deliverableVersion);

/** 在审核版本 */
psx(MTCiTunesAppInFlightVersion, inFlightVersion);

@end

@interface MTCiTunesAppInFlightVersion : NSObject

/** 问题数 */
pcx(NSString, issuesCount);

/** 支持的设备 */
psx(NSArray <NSString *>, supportedHardware);

/** 版本 */
pcx(NSString, version);

/** 状态 */
pcx(NSString, state);

/** 状态对应中文 */
pcx(NSString, stateStr);

/** 状态对应颜色 */
psx(UIColor, stateColor);

@end


@interface MTCiTunesAppDeliverableVersion : NSObject

/** 问题数 */
pcx(NSString, issuesCount);

/** 支持的设备 */
psx(NSArray <NSString *>, supportedHardware);

/** 状态 */
pcx(NSString, state);

/** 版本号 */
pcx(NSString, version);

/** 状态对应中文 */
pcx(NSString, stateStr);

/** 状态对应颜色 */
psx(UIColor, stateColor);

@end
