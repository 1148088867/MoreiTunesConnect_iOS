//
//  MTiTunesAppsCell.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTiTunesAppsCell.h"

@implementation MTiTunesAppsCell

- (void)setCellINFO {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.equalTo(self.contentView.mas_height).offset(-10);
    }];
    icon.layer.cornerRadius = 10;
    icon.layer.masksToBounds = YES;
    icon.layer.shouldRasterize = YES;
    icon.layer.rasterizationScale =[UIScreen mainScreen].scale;
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMakeNameWithSize(@"AmericanTypewriter-Cond", 16);
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_top).offset(5);
        make.left.equalTo(icon.mas_right).offset(15);
    }];
    
    QMUILabel *lastDate = [[QMUILabel alloc] init];
    selfClass(lastDate);
    lastDate.textColor = UIColorHex(#33302e);
    lastDate.font = UIFontMake(12);
    lastDate.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
    [self.contentView addSubview:lastDate];
    [lastDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(name.mas_bottom);
    }];
    
    UIImageView *status = [[UIImageView alloc] init];
    selfClass(status);
    [self.contentView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(lastDate.mas_bottom).offset(5);
        make.size.mas_offset(8);
    }];
    status.layer.cornerRadius = 4;
    status.layer.masksToBounds = YES;
    status.layer.shouldRasterize = YES;
    status.layer.rasterizationScale =[UIScreen mainScreen].scale;
    
    QMUILabel *version = [[QMUILabel alloc] init];
    selfClass(version);
    version.textColor = UIColorHex(#6e6c6b);
    version.font = UIFontMake(12);
    [self.contentView addSubview:version];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(status.mas_centerY);
        make.left.equalTo(status.mas_right).offset(3);
    }];
    
    QMUILabel *statusLab = [[QMUILabel alloc] init];
    selfClass(statusLab);
    statusLab.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
    [self.contentView addSubview:statusLab];
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
}

@end
