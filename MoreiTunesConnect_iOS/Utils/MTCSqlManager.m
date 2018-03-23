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

- (YTKKeyValueStore *)accountStore {
    if (!_accountStore) {
        _accountStore = [[YTKKeyValueStore alloc] initDBWithName:MTCACCOUNTDBNANE];
        [_accountStore createTableWithName:MTCACCOUNTTABLENAME];
    }
    return _accountStore;
}

- (NSArray <YTKKeyValueItem *>*)accountKeyValueItems {
    return [self.accountStore getAllItemsFromTable:MTCACCOUNTTABLENAME];
}


- (YTKKeyValueStore *)nfStore {
    if (!_nfStore) {
        _nfStore = [[YTKKeyValueStore alloc] initDBWithName:MTCNOTFOCUSDBNAME];
        [_nfStore createTableWithName:MTCNOTFOCUSTABLENAME];
    }
    return _nfStore;
}

- (NSArray<YTKKeyValueItem *> *)nfKeyValueItems {
    return [self.nfStore getAllItemsFromTable:MTCNOTFOCUSTABLENAME];
}

@end
