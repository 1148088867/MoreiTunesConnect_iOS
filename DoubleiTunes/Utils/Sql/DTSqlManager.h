//
//  DTSqlManager.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore.h>

@interface DTSqlManager : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, strong) YTKKeyValueStore *store;

@property(nonatomic, strong, readonly) NSArray<YTKKeyValueItem *> *keyValueItems;

@end
