//
//  MTSqlManager.h
//  MoreiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore.h>

@interface MTSqlManager : NSObject

+ (instancetype)sharedInstance;

psx(YTKKeyValueStore, store);

psrx(NSArray<YTKKeyValueItem *>, keyValueItems);

@end
