//
//  MTCNotFocusViewController.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCNotFocusViewController.h"
#import "MTCNotFocusView.h"

@interface MTCNotFocusViewController ()

@end

@implementation MTCNotFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"未显示的内容";
}

- (void)setUI {
    MTCNotFocusView *notFocusView = [[MTCNotFocusView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.baseView addSubview:notFocusView];
    [notFocusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    notFocusView.infoStr = [NSString stringWithFormat:@"当前共有%ld条内容", MTCSQL.nfKeyValueItems.count];
}

@end
