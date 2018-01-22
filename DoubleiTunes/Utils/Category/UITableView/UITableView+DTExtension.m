//
//  UITableView+DTExtension.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UITableView+DTExtension.h"

@implementation UITableView (DTExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sys = class_getInstanceMethod(self, @selector(initWithFrame:style:));
        Method my = class_getInstanceMethod(self, @selector(my_initWithFrame:style:));
        method_exchangeImplementations(sys, my);
    });
}

- (id)my_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    [self loadView];
    return [self my_initWithFrame:frame style:style];
}

- (void)loadView {
    
}

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
