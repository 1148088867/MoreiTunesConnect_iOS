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

+ (void)setLoginHeader {
    [DWNetworking setConfigRequestType:DWRequestTypeJSON responseType:DWResponseTypeJSON];
    [DWNetworking setHttpHeaderConfig:@{@"Accept":@"application/json, text/javascript, */*; q=0.01",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9",
                                        @"Connection":@"keep-alive",
                                        @"Content-Type":@"application/json",
                                        @"Host":@"idmsa.apple.com",
                                        @"Origin":@"https://idmsa.apple.com",
                                        @"Referer":@"https://idmsa.apple.com/appleauth/auth/signin?widgetKey=e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42&widgetDomain=https://itunesconnect.apple.com:443&font=sf",
                                        @"X-Apple-Widget-Key":@"e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42",
                                        @"X-Requested-With":@"XMLHttpRequest",
                                        }];
}

+ (void)setQueryHeader {
    [DWNetworking setHttpHeaderConfig:@{@"Accept":@"application/json, text/javascript, */*; q=0.01",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9",
                                        @"Connection":@"keep-alive",
                                        @"Host":@"itunesconnect.apple.com",
                                        @"Referer":@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app"
                                        }];
}

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

