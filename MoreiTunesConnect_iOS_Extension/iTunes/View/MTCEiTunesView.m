//
//  MTCiTunesView.m
//  MoreiTunesConnect_iOS_Extension
//
//  Created by Dwang on 2018/3/7.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCiTunesView.h"

@implementation MTCiTunesView

- (void)loadView {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(60);
    }];
    icon.layer.cornerRadius = 10;
    icon.layer.masksToBounds = YES;
    icon.layer.shouldRasterize = YES;
    icon.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    UILabel *name = [[UILabel alloc] init];
    selfClass(name);
    name.font = UIFontMakeNameWithSize(@"AmericanTypewriter-Cond", 16);
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_top).offset(5);
        make.left.equalTo(icon.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    UILabel *lastDate = [[UILabel alloc] init];
    selfClass(lastDate);
    lastDate.textColor = UIColorHex(#33302e);
    lastDate.font = UIFontSizeMake(12);
    lastDate.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
    [self addSubview:lastDate];
    [lastDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(name.mas_bottom);
    }];
    
    UIImageView *status = [[UIImageView alloc] init];
    selfClass(status);
    [self addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(lastDate.mas_bottom).offset(5);
        make.size.mas_offset(8);
    }];
    status.layer.cornerRadius = 4;
    status.layer.masksToBounds = YES;
    status.layer.shouldRasterize = YES;
    status.layer.rasterizationScale =[UIScreen mainScreen].scale;
    
    UILabel *version = [[UILabel alloc] init];
    selfClass(version);
    version.textColor = UIColorHex(#6e6c6b);
    version.font = UIFontSizeMake(12);
    [self addSubview:version];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(status.mas_centerY);
        make.left.equalTo(status.mas_right).offset(3);
    }];
    
    UILabel *statusLab = [[UILabel alloc] init];
    selfClass(statusLab);
    statusLab.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
    [self addSubview:statusLab];
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(status.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

@end
