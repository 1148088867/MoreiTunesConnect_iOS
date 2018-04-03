//
//  MTCStatusViewController.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/4/2.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCStatusViewController.h"
#import "MTCStatusView.h"

@interface MTCStatusViewController ()

psx(MTCStatusView, statusView);

@end

#define kitemSize (SCREEN_WIDTH-100)

@implementation MTCStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc] initWithStyle:QMUICollectionViewPagingLayoutStyleRotation];
    layout.itemSize = CGSizeMake(kitemSize, SCREEN_HEIGHT-SCREEN_WIDTH*0.3);
    layout.sectionInset = UIEdgeInsetsMake(0, 50, 0, 50);
    layout.allowsMultipleItemScroll = NO;
    MTCStatusView *statusView = [[MTCStatusView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    selfClass(statusView);
    statusView.showsVerticalScrollIndicator = NO;
    statusView.showsHorizontalScrollIndicator = NO;
    [self.baseView addSubview:statusView];
    [statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    [self statusNetworking];
}

- (void)statusNetworking {
    [self.progressHUD showLoading:@"查询数据中..."];
    weakOBJ(self);
    [MTCNetwork getUrl:MTCiTunesStatus(self.appid) callBack:^(id success, NSError *error) {
        [weak_self dismissProgressHUD];
        if (!error && [success[@"statusCode"] isEqualToString:@"SUCCESS"]) {
            weak_self.statusView.statusModel = [MTCStatusModel yy_modelWithJSON:success[@"data"]];
            [weak_self.statusView setContentOffset:CGPointMake(kitemSize*2+20, 0) animated:YES];
        }
    }];
}

@end
