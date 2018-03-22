//
//  MTCKPView.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/21.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCKPView.h"
#import <YYWebImage.h>
#import <KSPhotoBrowser.h>

@interface MTCKPView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation MTCKPView

- (void)loadView {
    QMUIFloatLayoutView *floatLayoutView = [[QMUIFloatLayoutView alloc] init];
    selfClass(floatLayoutView);
    floatLayoutView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    floatLayoutView.layer.borderWidth = PixelOne;
    floatLayoutView.layer.borderColor = UIColorSeparator.CGColor;
    self.tableHeaderView = floatLayoutView;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self stringCellHeight:self.des];
    }else if (indexPath.section == 1) {
        return [self stringCellHeight:self.releaseNote];
    }
    return SCREEN_WIDTH*0.8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColorClear;
    if (indexPath.section == 0) {
        cell.textLabel.attributedText = [self toolsEditColorString:self.des searchString:@"【描述】"];
        cell.textLabel.numberOfLines = 0;
    }else if (indexPath.section == 1) {
        cell.textLabel.attributedText = [self toolsEditColorString:self.releaseNote searchString:@"【此版本的新增内容】"];
        cell.textLabel.textColor = UIColorBlue;
        cell.textLabel.numberOfLines = 0;
    }else if (indexPath.section == 2) {
        UIScrollView *imgsView = [[UIScrollView alloc] init];
        imgsView.showsHorizontalScrollIndicator = NO;
        [imgsView setContentSize:CGSizeMake(10+(SCREEN_WIDTH/2.5+10)*self.imgLinks.count, 0)];
        [cell.contentView addSubview:imgsView];
        [imgsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        weakOBJ(imgsView);
        weakOBJ(self);
        NSMutableArray <KSPhotoItem *>*items = [NSMutableArray array];
        [self.imgLinks enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *img = [[UIImageView alloc] init];
            img.userInteractionEnabled = YES;
            [img yy_setImageWithURL:[NSURL URLWithString:obj] options:YYWebImageOptionProgressive];
            [weak_imgsView addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(cell.contentView);
                make.width.mas_offset(SCREEN_WIDTH/2.5);
                make.left.equalTo(weak_imgsView.mas_left).offset(idx*(SCREEN_WIDTH/2.5+10)+10);
            }];
            [items addObject:[KSPhotoItem itemWithSourceView:img imageUrl:[NSURL URLWithString:obj]]];
            [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:idx];
                [browser showFromViewController:weak_self.viewController];
            }]];
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (CGFloat)stringCellHeight:(NSString *)str {
    QMUILabel *lab = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    lab.text = str;
    lab.numberOfLines = 0;
    [lab sizeToFit];
    return lab.height;
}

- (NSMutableAttributedString *)toolsEditColorString:(NSString *)editString searchString:(NSString *)searchString {
    if (!editString) {
        return nil;
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:editString];
    NSRange range = [editString rangeOfString:searchString];
    [attStr addAttribute:NSForegroundColorAttributeName value:UIColorBlue range:NSMakeRange(0,range.location)];
    [attStr addAttribute:NSForegroundColorAttributeName value:UIColorBlack range:NSMakeRange(range.location,searchString.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:UIColorBlue range:NSMakeRange(range.location+searchString.length,editString.length-range.location-searchString.length)];
    return attStr;
}

@end
