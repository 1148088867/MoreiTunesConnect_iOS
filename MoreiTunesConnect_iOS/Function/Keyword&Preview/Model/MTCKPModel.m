//
//  MTCKPModel.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCKPModel.h"

@implementation MTCKPModel

@end

@implementation MTCKPDetailsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"des":@"description"};
}

@end

@implementation MTCKPINFOModel

@end
