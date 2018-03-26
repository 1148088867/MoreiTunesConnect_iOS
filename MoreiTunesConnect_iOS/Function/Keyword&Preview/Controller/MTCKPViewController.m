//
//  MTCKPViewController.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCKPViewController.h"
#import "MTCKPView.h"

@interface MTCKPViewController ()

psx(MTCKPView, kpView);

@end

@implementation MTCKPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    MTCKPView *kpView = [[MTCKPView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    kpView.separatorStyle = UITableViewCellSeparatorStyleNone;
    selfClass(kpView);
    [self.baseView addSubview:kpView];
    [kpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self detailNetworking];
}

- (void)detailNetworking {
    [self.progressHUD showLoading:@"获取详情中..."];
    weakOBJ(self);
    [MTCNetwork getUrl:MTCiTunesAppKP(self.appid, self.versionid) callBack:^(id success, NSError *error) {
        [weak_self dismissProgressHUD];
        if (!error && [success[@"statusCode"] isEqualToString:@"SUCCESS"]) {
            MTCKPModel *kpModel = [MTCKPModel yy_modelWithJSON:success[@"data"]];
            MTCKPDetailsModel *kpDetailModel = [MTCKPDetailsModel yy_modelWithJSON:kpModel.details.value[0]];
            weak_self.titleView.subtitle = kpModel.copyright.value;
            NSArray <NSString *>*keywords = [kpDetailModel.keywords.value componentsSeparatedByString:@","].count>2?[kpDetailModel.keywords.value componentsSeparatedByString:@","]:[kpDetailModel.keywords.value componentsSeparatedByString:@" "];
            [keywords enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QMUIGhostButton *keyword = [[QMUIGhostButton alloc] init];
                [keyword setTitle:obj forState:UIControlStateNormal];
                keyword.titleLabel.font = UIFontMake(14);
                keyword.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
                keyword.userInteractionEnabled = NO;
                [weak_self.kpView.floatLayoutView addSubview:keyword];
            }];
            [kpDetailModel.displayFamilies.value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"name"] isEqualToString:@"iphone6Plus"]) {
                    if ([obj[@"screenshots"][@"value"] count]) {
                        NSMutableArray *imgs = [NSMutableArray array];
                        [obj[@"screenshots"][@"value"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSLog(@"%@", obj[@"value"][@"assetToken"]);
                            [imgs addObject:[NSString stringWithFormat:@"%@", MTCiTunesAppPreview(obj[@"value"][@"assetToken"], @"1242")]];
                        }];
                        weak_self.kpView.imgLinks = imgs;
                    }
                }
            }];
            weak_self.kpView.des = [NSString stringWithFormat:@"【描述】\n%@", kpDetailModel.des.value];
            weak_self.kpView.releaseNote = [NSString stringWithFormat:@"【此版本的新增内容】\n%@", kpDetailModel.releaseNotes.value];
        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIEdgeInsets padding = UIEdgeInsetsMake(self.qmui_navigationBarMaxYInViewCoordinator + 36, 24, 36, 24);
    CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - UIEdgeInsetsGetHorizontalValue(padding);
    CGSize floatLayoutViewSize = [self.kpView.floatLayoutView sizeThatFits:CGSizeMake(contentWidth, CGFLOAT_MAX)];
    self.kpView.floatLayoutView.frame = CGRectMake(padding.left, padding.top, contentWidth, floatLayoutViewSize.height);
    [self.kpView reloadData];
}

@end
