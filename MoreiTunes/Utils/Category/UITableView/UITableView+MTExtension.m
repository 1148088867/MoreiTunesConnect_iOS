//
//  UITableView+MTExtension.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UITableView+MTExtension.h"

@interface UITableView ()

@end

@implementation UITableView (MTExtension)

- (void)dw_hasData {
    QMUILabel *noMoreData = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    noMoreData.font = UIFontMakeNameWithSize(@"AmericanTypewriter-Bold", 14);
    noMoreData.textAlignment = NSTextAlignmentCenter;
    noMoreData.text = @"没有更多数据了";
    self.tableFooterView = noMoreData;
}

- (UIImage *)dw_noDataViewImage {
    return UIImageMake(@"无数据");
}

- (NSString *)dw_noDataViewMessage {
    return nil;
}

@end
