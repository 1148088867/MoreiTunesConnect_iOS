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
            weak_self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"截取" tintColor:UIColorWhite position:QMUINavigationButtonPositionNone target:weak_self action:@selector(rightBarButtonItemDidClick)];
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

- (void)rightBarButtonItemDidClick {
    [self snipImg:[self.kpView qmui_snapshotLayerImage]];
}

- (void)snipImg:(UIImage *)img {
    weakOBJ(self);
    QMUIAlertController *screenhotAlert = [QMUIAlertController alertControllerWithTitle:@"提示" message:@"请选择对截取内容所要进行的操作" preferredStyle:QMUIAlertControllerStyleActionSheet];
    [screenhotAlert addAction:[QMUIAlertAction actionWithTitle:@"分享至好友" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        [weak_self showActivityViewControllerWithItems:@[img] obj:weak_self];
    }]];
    [screenhotAlert addAction:[QMUIAlertAction actionWithTitle:@"保存至相册" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        [weak_self.progressHUD showLoading:@"请稍后..."];
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }]];
    [screenhotAlert addCancelAction];
    [screenhotAlert showWithAnimated:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [self dismissProgressHUD];
    if (!error) {
        [ISMessages showCardAlertWithTitle:@"存储成功" message:[NSString stringWithFormat:@"您已成功将反馈信息截图保存至系统相册"] duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
    }else {
        [ISMessages showCardAlertWithTitle:@"存储失败" message:error.description duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

@end
