//
//  MTCWKWebViewController.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/4/2.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface MTCWKWebViewController ()<WKNavigationDelegate>

psx(WKWebView, webView);

psx(UIProgressView, progressView);

@end

@implementation MTCWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WebBrowser";
}

- (instancetype)initWithRequestURLString:(NSString *)urlString{
    self = [super init];
    if (self) {
        [self loadRequestURLString:urlString];
    }
    return self;
}

- (void)loadRequestURLString:(NSString *)urlString {
    self.view.backgroundColor = UIColorWhite;
    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.backgroundColor = self.view.backgroundColor;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.baseView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.backgroundColor = UIColorClear;
    self.progressView.progressTintColor = UIColorGreen;
    self.progressView.trackTintColor = UIColorClear;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.webView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.webView);
        make.height.mas_offset(2);
    }];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (![webView.backForwardList.currentItem.URL.absoluteString isEqualToString:webView.URL.absoluteString]) {
        [self.progressHUD showLoading:@"Loading..."];
        self.progressView.hidden = NO;
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.view bringSubviewToFront:self.progressView];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
    [self dismissProgressHUD];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self dismissProgressHUD];
    [webView reload];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] &&
       [[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)dealloc {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end

