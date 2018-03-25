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

psx(MTCNotFocusView, notFocusView);

@end

@implementation MTCNotFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"未显示的内容";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:0 title:@"编辑" tintColor:UIColorWhite position:0 target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    MTCNotFocusView *notFocusView = [[MTCNotFocusView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(notFocusView);
    [self.baseView addSubview:notFocusView];
    [notFocusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    notFocusView.infoStr = [NSString stringWithFormat:@"当前共有%ld条内容", MTCSQL.nfKeyValueItems.count];
}

- (void)rightBarButtonItemDidClick {
    self.notFocusView.editing = !self.notFocusView.isEditing;
    self.navigationItem.rightBarButtonItem.title = [self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]?@"完成":@"编辑";
}

@end
