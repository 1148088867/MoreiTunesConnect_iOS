//
//  DTAccountCell.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/21.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTAccountCell.h"

@implementation DTAccountCell

- (void)setCellINFO {
    QMUILabel *mail = [[QMUILabel alloc] init];
    selfClass(mail);
    mail.font = UIFontMakeNameWithSize(@"AmericanTypewriter-Bold", 16);
    [self.contentView addSubview:mail];
    [mail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(25);
        make.top.equalTo(self.contentView.mas_top).offset(5);
    }];
    
    QMUILabel *note = [[QMUILabel alloc] init];
    note.font = UIFontMakeNameWithSize(@"AmericanTypewriter", 16);
    selfClass(note);
    note.textColor = UIColorHex(#111111);
    [self.contentView addSubview:note];
    [note mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mail.mas_left);
        make.top.equalTo(mail.mas_bottom).offset(10);
    }];
    
    QMUILabel *addTime = [[QMUILabel alloc] init];
    addTime.font = UIFontMakeNameWithSize(@"CourierNewPS-BoldMT", 16);
    selfClass(addTime);
    addTime.textColor = UIColorGray;
    [self.contentView addSubview:addTime];
    [addTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.centerY.equalTo(note.mas_centerY);
    }];
    
}

@end
