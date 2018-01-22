//
//  DTAppsCell.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTAppsCell.h"

@implementation DTAppsCell

- (void)setCellINFO {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(25);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.equalTo(self.contentView.mas_height).offset(-10);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 16);
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_top).offset(5);
        make.left.equalTo(icon.mas_right).offset(10);
    }];
    
    QMUILabel *status = [[QMUILabel alloc] init];
    selfClass(status);
    status.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 14);
    [self.contentView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(icon.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
}

@end
