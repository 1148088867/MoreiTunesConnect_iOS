//
//  MTCNetwork.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCNetwork.h"
#import <DWNetworking.h>

@implementation MTCNetwork

+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success, NSError *error))callBack {
    [DWNetworking postUrlString:url params:params resultCallBack:^(id success, NSError *error, BOOL isCache) {
        callBack(success, error);
    }];
}

+ (void)getUrl:(NSString *)url callBack:(void(^)(id success, NSError *error))callBack {
    [DWNetworking getUrlString:url params:nil resultCallBack:^(id success, NSError *error, BOOL isCache) {
        callBack(success, error);
    }];
}

@end
