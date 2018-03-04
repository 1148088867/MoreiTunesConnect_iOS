//
//  UITableView+DTExtension.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UITableView+DTExtension.h"

@implementation UITableView (DTExtension)

- (void)hasData {
    self.mj_footer.hidden = NO;
}

- (UIImage *)cd_noDataViewImage {
    self.mj_footer.hidden = YES;
    return UIImageMake(@"无数据");
}

- (NSString *)cd_noDataViewMessage {
    return nil;
}

@end
