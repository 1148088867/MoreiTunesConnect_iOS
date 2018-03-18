//
//  MTCResolutionCenterModel.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCResolutionCenterModel.h"

@implementation MTCResolutionCenterModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"backId":@"id"};
}

@end

@implementation MTCResolutionCenterMessagesModel

- (NSString *)date {
    NSString *string = [NSString stringWithFormat:@"%f", [_date integerValue]/1000.0];
    return [NSDate dateTimeStamp:string withFormat:@"yyyy-MM-dd HH:mm"];
}

@end
