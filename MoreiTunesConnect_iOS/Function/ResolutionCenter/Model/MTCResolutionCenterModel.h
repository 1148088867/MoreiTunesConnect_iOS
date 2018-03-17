//
//  MTCResolutionCenterModel.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTCResolutionCenterMessagesModel;

@interface MTCResolutionCenterModel : NSObject

/** 版本号 */
pcx(NSString, version);

/** 版本号id */
pcx(NSString, versionId);

/** 反馈id */
pcx(NSString, backId);

/** 反馈消息 */
psx(NSArray<MTCResolutionCenterMessagesModel *>, messages);

@end


@interface MTCResolutionCenterMessagesModel : NSObject

/** 是否为苹果反馈 */
pax(BOOL, appleMsg);

/** 来源 */
pcx(NSString, from);

/** 时间 */
pcx(NSString, date);

/** 反馈的内容 */
pcx(NSString, body);

@end
