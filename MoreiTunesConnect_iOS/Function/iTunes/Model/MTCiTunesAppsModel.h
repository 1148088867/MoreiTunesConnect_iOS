//
//  MTCiTunesAppsModel.h
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTCiTunesAppVersionModel;
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

psx(MTCiTunesAppInFlightVersion, inFlightVersion);

@end

@interface MTCiTunesAppInFlightVersion : NSObject

/** 版本 */
pcx(NSString, version);

/** 状态 */
pcx(NSString, state);

/** 状态对应中文 */
pcx(NSString, stateStr);

/** 状态对应颜色 */
psx(UIColor, stateColor);

@end

