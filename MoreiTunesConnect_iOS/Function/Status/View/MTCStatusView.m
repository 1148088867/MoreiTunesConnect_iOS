//
//  MTCStatusView.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/4/2.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCStatusView.h"
#import "MTCStatusCell.h"
#import "MTCKPViewController.h"
#import "MTCResolutionCenterViewController.h"

@interface MTCStatusView ()<UICollectionViewDelegate, UICollectionViewDataSource>

psx(NSArray<NSString *>, statusArr);

@end

@implementation MTCStatusView

- (void)loadView {
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = UIColorWhite;
    [self registerClass:[MTCStatusCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTCStatusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.statusType.text = self.statusArr[indexPath.row];
    cell.contentView.backgroundColor = UIColorRandom;
    cell.contentView.layer.cornerRadius = 15;
    cell.contentView.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//        MTCStatusCell *cell = (MTCStatusCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    NSArray <MTCStatusPlatformsModel *>*platformsModel = [NSArray yy_modelArrayWithClass:[MTCStatusPlatformsModel class] json:self.statusModel.platforms];
    switch (indexPath.row) {
        case 0:{
            if (platformsModel.firstObject.deliverableVersion.version) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.statusModel.appStoreUrl]];
            }else {
                [ISMessages showCardAlertWithTitle:@"打开App Store失败" message:[NSString stringWithFormat:@"您当前名为\"%@\"的软件似乎还没有成功上线哦！！！", self.viewController.title] duration:2.55 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeWarning alertPosition:ISAlertPositionTop didHide:nil];
            }
        }break;
        case 1:{
            MTCStatusVersionModel *versionModel = platformsModel.firstObject.deliverableVersion;
            if (versionModel.version) {
                MTCKPViewController *kp = [[MTCKPViewController alloc] init];
                kp.title = self.viewController.title;
                kp.appid = self.statusModel.adamId;
                kp.versionid = versionModel.versionID;
                [self.viewController.navigationController pushViewController:kp animated:YES];
            }else {
                [ISMessages showCardAlertWithTitle:@"打开详情失败" message:[NSString stringWithFormat:@"您当前名为\"%@\"的软件似乎还没有成功上线哦！！！", self.viewController.title] duration:2.55 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeWarning alertPosition:ISAlertPositionTop didHide:nil];
            }
        }break;
        case 2:{
            MTCStatusVersionModel *versionModel = platformsModel.firstObject.inFlightVersion;
            if (versionModel.issuesCount) {
                MTCResolutionCenterViewController *resolutionCenter = [[MTCResolutionCenterViewController alloc] init];
                resolutionCenter.title = self.viewController.title;
                resolutionCenter.appid = self.statusModel.adamId;
                resolutionCenter.titleView.subtitle = [NSString stringWithFormat:@"问题数: %ld个", versionModel.issuesCount];
                [self.viewController.navigationController pushViewController:resolutionCenter animated:YES];
            }else {
                [ISMessages showCardAlertWithTitle:@"打开解决中心失败" message:[NSString stringWithFormat:@"您当前名为\"%@\"的软件似乎还没有被审核人员拒绝哦！！！", self.viewController.title] duration:2.55 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeWarning alertPosition:ISAlertPositionTop didHide:nil];
            }
        }break;
        case 3:{
            MTCStatusVersionModel *versionModel = platformsModel.firstObject.inFlightVersion;
            if (versionModel.versionID) {
                MTCResolutionCenterViewController *resolutionCenter = [[MTCResolutionCenterViewController alloc] init];
                resolutionCenter.title = self.viewController.title;
                resolutionCenter.appid = self.statusModel.adamId;
                resolutionCenter.titleView.subtitle = [NSString stringWithFormat:@"问题数: %ld个", versionModel.issuesCount];
                [self.viewController.navigationController pushViewController:resolutionCenter animated:YES];
            }else {
                [ISMessages showCardAlertWithTitle:@"打开解决中心失败" message:[NSString stringWithFormat:@"您当前名为\"%@\"的软件似乎还没有被审核人员拒绝的经历哦！！！", self.viewController.title] duration:2.55 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeWarning alertPosition:ISAlertPositionTop didHide:nil];
            }
        }break;
        case 4:{
            MTCStatusVersionModel *versionModel = platformsModel.firstObject.inFlightVersion;
            if (versionModel.versionID) {
                MTCKPViewController *kp = [[MTCKPViewController alloc] init];
                kp.title = self.viewController.title;
                kp.appid = self.statusModel.adamId;
                kp.versionid = versionModel.versionID;
                [self.viewController.navigationController pushViewController:kp animated:YES];
            }else {
                [ISMessages showCardAlertWithTitle:@"打开详情失败" message:[NSString stringWithFormat:@"您当前名为\"%@\"的软件似乎无法查看详情，请选择已上线菜单试试哦！！！", self.viewController.title] duration:2.55 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeWarning alertPosition:ISAlertPositionTop didHide:nil];
            }
        }break;
        default:
            break;
    }
}

- (NSArray<NSString *> *)statusArr {
    if (!_statusArr) {
        _statusArr = @[@"打开App Store", @"打开详情", @"打开解决中心", @"直接进入解决中心", @"直接进入详情"];
    }
    return _statusArr;
}

@end

