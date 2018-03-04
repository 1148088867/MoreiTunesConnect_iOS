//
//  DTCreateAccountCell.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTCreateAccountCell.h"

@implementation DTCreateAccountCell

- (void)setCellINFO {
    QMUITextField *field = [[QMUITextField alloc] init];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.font = UIFontMake(18);
    selfClass(field);
    [self.contentView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.bottom.equalTo(self.contentView);
    }];
}

@end
