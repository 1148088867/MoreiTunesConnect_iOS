//
//  MTCiTunesAppsModel.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCiTunesAppsModel.h"

@implementation MTCiTunesAppsModel

- (NSString *)lastModifiedDate {
    NSTimeInterval interval = [_lastModifiedDate doubleValue]/1000.0;
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creat = [NSDate dateWithTimeIntervalSince1970:interval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *compas = [calendar components:unit fromDate:creat toDate:nowDate options:0];
    if (compas.year) {
        return [NSString stringWithFormat:@"%ld years ago", (long)compas.year];
    }else if (compas.month) {
        return [NSString stringWithFormat:@"%ld months ago", (long)compas.month];
    }else if (compas.day) {
        return [NSString stringWithFormat:@"%ld days ago", (long)compas.day];
    }else if (compas.hour) {
        return [NSString stringWithFormat:@"%ld hours ago", (long)compas.hour];
    }else if (compas.minute) {
        return [NSString stringWithFormat:@"%ld minutes ago", (long)compas.minute];
    }
    return @"刚刚";
}

- (NSString *)iconUrl {
    return _iconUrl?_iconUrl:@"";
}

@end

@implementation MTCiTunesAppVersionModel

@end

@implementation MTCiTunesAppInFlightVersion

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

- (UIColor *)stateColor {
    if ([_state isEqualToString:@"inReview"] ||
        [_state isEqualToString:@"waitingForReview"] ||
        [_state isEqualToString:@"prepareForUpload"]) {
        return UIColorMakeRGB(255, 207, 71);
    }else if ([_state isEqualToString:@"devRejected"] ||
              [_state isEqualToString:@"rejected"] ||
              [_state isEqualToString:@"metadataRejected"]) {
        return UIColorMakeRGB(250, 58, 58);
    }else if ([_state isEqualToString:@"readyForSale"]) {
        return UIColorMakeRGB(159, 214, 97);
    }
    return UIColorRandom;
}

@end

@implementation MTCiTunesAppDeliverableVersion

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

- (UIColor *)stateColor {
    if ([_state isEqualToString:@"inReview"] ||
        [_state isEqualToString:@"waitingForReview"] ||
        [_state isEqualToString:@"prepareForUpload"]) {
        return UIColorMakeRGB(255, 207, 71);
    }else if ([_state isEqualToString:@"devRejected"] ||
              [_state isEqualToString:@"rejected"] ||
              [_state isEqualToString:@"metadataRejected"]) {
        return UIColorMakeRGB(250, 58, 58);
    }else if ([_state isEqualToString:@"readyForSale"]) {
        return UIColorMakeRGB(159, 214, 97);
    }
    return UIColorRandom;
}

@end
