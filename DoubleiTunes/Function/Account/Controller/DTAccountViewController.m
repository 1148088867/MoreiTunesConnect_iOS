//
//  DTAccountViewController.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTAccountViewController.h"
#import "DTAccountView.h"
#import "DTCreateAccountViewController.h"

@interface DTAccountViewController ()

/** 账户列表 */
@property(nonatomic, strong) DTAccountView *accountView;

@end

@implementation DTAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AccountCenter";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"添加") tintColor:UIColorWhite position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    DTAccountView *accountView = [[DTAccountView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(accountView);
    [self.baseView addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)rightBarButtonItemDidClick {
    DTCreateAccountViewController *createAccount = [[DTCreateAccountViewController alloc] init];
    createAccount.title = @"CreateAccount";
    [self.navigationController pushViewController:createAccount animated:YES];
    weakOBJ(self);
    createAccount.createAccountSuccess = ^(DTAccountModel *accountModel) {
        [weak_self.accountView.accountModelArrM insertObject:accountModel atIndex:0];
        [weak_self.accountView reloadData];
    };
}

@end
