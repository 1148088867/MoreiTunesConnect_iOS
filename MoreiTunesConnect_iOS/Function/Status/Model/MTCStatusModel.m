//
//  MTCStatusModel.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/4/2.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCStatusModel.h"

@implementation MTCStatusModel

@end

@implementation MTCStatusPlatformsModel

@end


@implementation MTCStatusVersionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"versionID":@"id"};
}

- (NSString *)stateStr {
    if ([_state isEqualToString:@"inReview"]) {
        return @"正在审核";
    }else if ([_state isEqualToString:@"waitingForReview"]) {
        return @"等待审核";
    }else if ([_state isEqualToString:@"prepareForUpload"]) {
        return @"准备提交";
    }else if ([_state isEqualToString:@"devRejected"]) {
        return @"被开发人员拒绝";
    }else if ([_state isEqualToString:@"rejected"]) {
        return @"被拒绝";
    }else if ([_state isEqualToString:@"metadataRejected"]) {
        return @"元数据被拒绝";
    }else if ([_state isEqualToString:@"readyForSale"]) {
        return @"可供销售";
    }
    return _state;
}

@end
