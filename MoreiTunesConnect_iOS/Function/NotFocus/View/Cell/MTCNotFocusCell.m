//
//  MTCNotFocusCell.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCNotFocusCell.h"

@implementation MTCNotFocusCell

- (void)setCellINFO {
    UIImageView *icon = [[UIImageView alloc] init];
    icon.backgroundColor = UIColorRandom;
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
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    QMUILabel *hiddenTime = [[QMUILabel alloc] init];
    selfClass(hiddenTime);
    hiddenTime.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
    [self.contentView addSubview:hiddenTime];
    [hiddenTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(icon.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
}

@end
