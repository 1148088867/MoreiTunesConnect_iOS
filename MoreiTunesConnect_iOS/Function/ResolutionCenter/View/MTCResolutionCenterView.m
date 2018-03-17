//
//  MTCResolutionCenterView.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCResolutionCenterView.h"
#import "FanYiSDK.h"

@interface MTCResolutionCenterView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation MTCResolutionCenterView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.resolutionCenterArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resolutionCenterArr[section].messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    MTCResolutionCenterMessagesModel *messageModel = [MTCResolutionCenterMessagesModel yy_modelWithJSON:self.resolutionCenterArr[indexPath.section].messages[indexPath.row]];
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithData:[messageModel.body dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    MTCResolutionCenterMessagesModel *messageModel = [MTCResolutionCenterMessagesModel yy_modelWithJSON:self.resolutionCenterArr[indexPath.section].messages[indexPath.row]];
    weakOBJ(self);
    QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:@"提示" message:@"请选择所要进行的操作" preferredStyle:QMUIAlertControllerStyleActionSheet];
    [alert addAction:[QMUIAlertAction actionWithTitle:@"翻译当前信息" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        [weak_self translationMsg:messageModel.body];
    }]];
    [alert addAction:[QMUIAlertAction actionWithTitle:@"截取反馈信息" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        [MTCBaseController.progressHUD showLoading:@"请稍后..."];
        QMUITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImageWriteToSavedPhotosAlbum([cell qmui_snapshotLayerImage], self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }]];
    [alert addAction:[QMUIAlertAction actionWithTitle:@"复制反馈信息" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        [weak_self copyMsg:[weak_self filterHTML:[[[messageModel.body stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"] stringByReplacingOccurrencesOfString:@"<BR/>" withString:@"\n"]]];
    }]];
    
    [alert addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {}]];
    [alert showWithAnimated:YES];
}

- (void)translationMsg:(NSString *)msg {
    [MTCBaseController.progressHUD showLoading:@"翻译中..."];
    YDTranslateRequest *translateRequest  = [YDTranslateRequest request];
    YDTranslateParameters *parameters = [YDTranslateParameters targeting];
    parameters.source = @"youdaosw";
    parameters.from = YDLanguageTypeEnglish;
    parameters.to = YDLanguageTypeChinese;
    translateRequest.translateParameters = parameters;
    weakOBJ(self);
    [translateRequest lookup:msg WithCompletionHandler:^(YDTranslateRequest *request, YDTranslate *response, NSError *error) {
        [MTCBaseController dismissProgressHUD];
        NSString *translation = [weak_self filterHTML:[[[response.translation.firstObject stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"] stringByReplacingOccurrencesOfString:@"<BR/>" withString:@"\n"]];
        if (!error && !translation.isEmpty) {
            QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"翻译信息" message:translation preferredStyle:QMUIAlertControllerStyleAlert];
            [alert addAction:[QMUIAlertAction actionWithTitle:@"复制" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
                [weak_self copyMsg:translation];
            }]];
            [alert addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {}]];
            [alert showWithAnimated:YES];
        }else {
            [ISMessages showCardAlertWithTitle:@"翻译失败" message:error.description duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

- (void)copyMsg:(NSString *)msg {
    [UIPasteboard generalPasteboard].string = msg;
    [MTCBaseController.progressHUD showLoading:@"请稍后..."];
    weakOBJ(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MTCBaseController dismissProgressHUD];
        if ([[UIPasteboard generalPasteboard].string isEqualToString:[weak_self filterHTML:msg]]) {
            [ISMessages showCardAlertWithTitle:@"复制成功" message:[NSString stringWithFormat:@"您已成功将反馈信息复制至系统粘贴板"] duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
        }else {
            [ISMessages showCardAlertWithTitle:@"复制失败" message:[NSString stringWithFormat:@"由于未知原因导致复制失败，请尝试重新复制"] duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
        }
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [MTCBaseController dismissProgressHUD];
    if (!error) {
        [ISMessages showCardAlertWithTitle:@"存储成功" message:[NSString stringWithFormat:@"您已成功将反馈信息截图保存至系统相册"] duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
    }else {
        [ISMessages showCardAlertWithTitle:@"存储失败" message:error.description duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (NSString *)filterHTML:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO) {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

- (NSArray<MTCResolutionCenterModel *> *)resolutionCenterArr {
    if (!_resolutionCenterArr) {
        _resolutionCenterArr = [NSArray array];
    }
    return _resolutionCenterArr;
}

@end
