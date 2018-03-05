//
//  MTCNetwork.h
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCNetwork : NSObject

+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success, NSError *error))callBack;

+ (void)getUrl:(NSString *)url callBack:(void(^)(id success, NSError *error))callBack;

@end
