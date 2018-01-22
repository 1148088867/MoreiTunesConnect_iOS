//
//  DTiTunesViewController.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/22.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTiTunesViewController.h"
#import <WebKit/WebKit.h>

@interface DTiTunesViewController ()<WKNavigationDelegate, WKUIDelegate>

/** 进度条 */
@property (nonatomic, strong) UIProgressView *progressView;

/** wkWebView */
@property(nonatomic, strong) WKWebView *wkWebView;

@end

@implementation DTiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    self.progressHUD.label.text = @"加载iTunes内容中...";
    [self.progressHUD showAnimated:YES];
    WKWebView *wkWebView = [[WKWebView alloc] init];
    selfClass(wkWebView);
    wkWebView.navigationDelegate = self;
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DTiTunesLogin]]];
    [self.baseView addSubview:wkWebView];
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    UIProgressView *progressView = [[UIProgressView alloc] init];
    selfClass(progressView);
    progressView.tintColor = UIColorBlack;
    progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.baseView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(2);
    }];
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            weakOBJ(self);
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weak_self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weak_self.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
    if ([webView.URL.absoluteString isEqualToString:DTiTunesLoginSuccess]) {
        [self dismissProgressHUD];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DTiTunesApps]]];
    }
    if ([webView.URL.absoluteString isEqualToString:DTiTunesLogin]) {
        [webView evaluateJavaScript:[NSString stringWithFormat:@"document.getElementById('accountname').value='%@';", self.accountModel.mail.decryptAESString] completionHandler:^(id _Nullable email, NSError * _Nullable error) {}];
        [webView evaluateJavaScript:[NSString stringWithFormat:@"document.getElementById('accountpassword').value='%@';", self.accountModel.password.decryptAESString] completionHandler:^(id _Nullable password, NSError * _Nullable error) {}];
        [webView evaluateJavaScript:@"document.forms[0].submit(); " completionHandler:^(id _Nullable success, NSError * _Nullable error) {}];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self dismissProgressHUD];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DTiTunesApps]]];
}

- (void)rightBarButtonItemDidClick {
    
}

@end
