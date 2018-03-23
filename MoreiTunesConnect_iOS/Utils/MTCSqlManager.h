//
//  MTCSqlManager.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore.h>

@interface MTCSqlManager : NSObject

+ (instancetype)sharedInstance;

/** 账号 */
psx(YTKKeyValueStore, accountStore);
psrx(NSArray<YTKKeyValueItem *>, accountKeyValueItems);

/** 不关注的App */
psx(YTKKeyValueStore, nfStore);
psrx(NSArray<YTKKeyValueItem *>, nfKeyValueItems);

@end
