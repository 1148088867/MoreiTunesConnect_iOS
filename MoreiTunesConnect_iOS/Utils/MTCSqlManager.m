//
//  MTCSqlManager.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCSqlManager.h"

@implementation MTCSqlManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MTCSqlManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (YTKKeyValueStore *)store {
    if (!_store) {
        _store = [[YTKKeyValueStore alloc] initDBWithName:MTCAccountDBName];
        [_store createTableWithName:MTCAccountTableName];
    }
    return _store;
}

- (NSArray <YTKKeyValueItem *>*)keyValueItems {
    return [self.store getAllItemsFromTable:MTCAccountTableName];
}

@end
