//
//  MTCStatusCell.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/4/3.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCStatusCell.h"

@implementation MTCStatusCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCellINFO];
    }
    return self;
}

- (void)setCellINFO {
    
    QMUILabel *statusType = [[QMUILabel alloc] init];
    statusType.textColor = UIColorRandom;
    statusType.textAlignment = NSTextAlignmentCenter;
    statusType.font = UIFontMake(24);
    selfClass(statusType);
    [self.contentView addSubview:statusType];
    [statusType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
