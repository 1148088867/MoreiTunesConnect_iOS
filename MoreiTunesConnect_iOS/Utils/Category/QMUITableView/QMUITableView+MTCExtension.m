//
//  UITableView+MTCExtension.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableView+MTCExtension.h"

@interface QMUITableView ()

@end

@implementation QMUITableView (MTCExtension)
@dynamic infoStr;

- (void)setInfoStr:(NSString *)infoStr {
    QMUILabel *infoLab = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    infoLab.font = UIFontMakeNameWithSize(@"AmericanTypewriter-Bold", 14);
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.text = infoStr;
    infoLab.numberOfLines = 0;
    self.tableFooterView = infoLab;
}

- (void)dw_hasData {
}

- (UIImage *)dw_noDataViewImage {
    return UIImageMake(@"无数据");
}

- (NSString *)dw_noDataViewMessage {
    return nil;
}

@end
