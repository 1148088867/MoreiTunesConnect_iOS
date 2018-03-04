//
//  UITableView+Placeholder.m
//  TableViewPlaceholder
//
//  Created by Dwang on 2017/10/16.
//  Copyright © 2017年 Dwang. All rights reserved.
//

#import "UITableView+DWExtension.h"
#import <objc/runtime.h>

@protocol DWTableViewDelegat <NSObject>
@optional

/** 完全自定义占位图 */
- (UIView *)dw_noDataView;

/** 使用默认占位图, 提供一张图片, 可不提供, 默认不显示 */
- (UIImage *)dw_noDataViewImage;

/** 使用默认占位图, 提供显示文字, 可不提供, 默认为暂无数据 */
- (NSString *)dw_noDataViewMessage;

/** 使用默认占位图, 提供显示文字颜色, 可不提供, 默认为灰色 */
- (UIColor *)dw_noDataViewMessageColor;

/** 使用默认字体, 提供显示文字字体, 可不提供, 默认为系统字体、字号17 */
- (UIFont *)dw_noDataViewMessageFont;

/** 出现数据时会走此代理 */
- (void)dw_hasData;

@end

@implementation UITableView (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sys_Method = class_getInstanceMethod(self, @selector(reloadData));
        Method dw_Method = class_getInstanceMethod(self, @selector(dw_reloadData));
        method_exchangeImplementations(sys_Method, dw_Method);
    });
}

- (void)dw_reloadData {
    [self dw_reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger numberOfSections = [self numberOfSections];
        BOOL hasData = NO;
        for (int i = 0; i < numberOfSections; i ++) {
            if ([self numberOfRowsInSection:i]) {
                hasData = YES;
                break;
            }
        }
        [self dw_hasData:hasData];
    });
}

- (void)dw_hasData:(BOOL)hasData {
    if (hasData) {
        self.backgroundView = nil;
        if ([self.delegate respondsToSelector:@selector(dw_hasData)]) {
            [self.delegate performSelector:@selector(dw_hasData)];
        }
        return;
    }
    self.tableFooterView = [UIView new];
    if ([self.delegate respondsToSelector:@selector(dw_noDataView)]) {
        self.backgroundView = [self.delegate performSelector:@selector(dw_noDataView)];
        return;
    }
    
    UIImage *img = nil;
    NSString *msg = @"暂无数据";
    UIColor *msgColor = [UIColor lightGrayColor];
    UIFont *msgFont = [UIFont systemFontOfSize:17];
    if ([self.delegate respondsToSelector:@selector(dw_noDataViewImage)]) {
        img = [self.delegate performSelector:@selector(dw_noDataViewImage)];
    }
    if ([self.delegate respondsToSelector:@selector(dw_noDataViewMessage)]) {
        msg = [self.delegate performSelector:@selector(dw_noDataViewMessage)];
    }
    if ([self.delegate respondsToSelector:@selector(dw_noDataViewMessageColor)]) {
        msgColor = [self.delegate performSelector:@selector(dw_noDataViewMessageColor)];
    }
    if ([self.delegate respondsToSelector:@selector(dw_noDataViewMessageFont)]) {
        msgFont = [self.delegate performSelector:@selector(dw_noDataViewMessageFont)];
    }
    if (img) {
       self.backgroundView = [self dw_defaultNoDataViewWithImage:img message:msg msgColor:msgColor msgFont:msgFont];
    }else {
       self.backgroundView = [self dw_defaultNoDataViewWithMessage:msg msgColor:msgColor msgFont:msgFont];
    }
}

- (UIView *)dw_defaultNoDataViewWithMessage:(NSString *)message msgColor:(UIColor *)msgColor msgFont:(UIFont *)msgFont {
    UILabel *lab = [[UILabel alloc] init];
    lab.text = message;
    lab.textColor = msgColor;
    lab.font = msgFont;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab sizeToFit];
    return lab;
}

- (UIView *)dw_defaultNoDataViewWithImage:(UIImage *)image message:(NSString *)message msgColor:(UIColor *)msgColor msgFont:(UIFont *)msgFont {
    CGFloat cX = self.bounds.size.width/2;
    CGFloat cY = self.bounds.size.height * (1 - 0.618);
    CGFloat iW = image.size.width;
    CGFloat iH = image.size.height;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(cX - iW / 2, cY - iH / 2, iW, iH);
    imgView.image = image;
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = message;
    lab.textColor = msgColor;
    lab.font = msgFont;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame)+24, self.bounds.size.width, lab.font.lineHeight);
    
    UIView *bgView = [[UIView alloc] init];
    [bgView addSubview:imgView];
    [bgView addSubview:lab];
    return bgView;
}

@end
