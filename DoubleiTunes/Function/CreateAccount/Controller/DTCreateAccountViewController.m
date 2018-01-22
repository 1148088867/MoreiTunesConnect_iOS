//
//  DTCreateAccountViewController.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTCreateAccountViewController.h"
#import "DTCreateAccountView.h"

/** 记录信息是否输入完整 */
static BOOL hasText = NO;

@interface DTCreateAccountViewController ()

@property(nonatomic, strong) DTCreateAccountView *createAccountView;

@end

@implementation DTCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    DTCreateAccountView *createAccountView = [[DTCreateAccountView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(createAccountView);
    [self.baseView addSubview:createAccountView];
    [createAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    createAccountView.tableFooterView = [self tableFooterView];
    if (self.accountModel) {
        DTAccountModel *model = self.accountModel;
        createAccountView.infos = @[model.mail.decryptAESString,
                                    model.password.decryptAESString,
                                    model.note.decryptAESString];
    }
}

- (UIView *)tableFooterView {
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    QMUIButton *save = [[QMUIButton alloc] init];
    save.backgroundColor = self.navigationController.navigationBar.barTintColor;
    save.titleLabel.font = UIFontMake(18);
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [tableFooterView addSubview:save];
    [save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tableFooterView.mas_bottom);
        make.left.equalTo(tableFooterView.mas_left).offset(15);
        make.right.equalTo(tableFooterView.mas_right).offset(-15);
        make.height.mas_offset(44);
    }];
    save.layer.cornerRadius = 15;
    save.layer.masksToBounds = YES;
    [save addTarget:self action:@selector(saveDidClick) forControlEvents:UIControlEventTouchUpInside];
    return tableFooterView;
}

- (void)saveDidClick {
    hasText = YES;
    NSArray <NSString *>*keys = @[@"mail", @"password", @"note"];
    weakOBJ(self);
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUITextField *field = [weak_self.createAccountView viewWithTag:idx+100];
        [field becomeFirstResponder];
        if (![field.text stringByReplacingOccurrencesOfString:@" " withString:@""].length) {
            [ISMessages showCardAlertWithTitle:@"存储失败" message:field.placeholder duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            hasText = NO;
            *stop = YES;
        }
    }];
    if (hasText) {
        NSMutableDictionary *account = [NSMutableDictionary dictionary];
        weakOBJ(account);
        [account setObject:[NSDate currentTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"] forKey:@"addTime"];
        [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QMUITextField *field = [weak_self.createAccountView viewWithTag:idx+100];
            [weak_account setObject:[field.text stringByReplacingOccurrencesOfString:@" " withString:@""].encryptAESString forKey:obj];
        }];
        [DTSQL.store putObject:account withId:account[@"addTime"] intoTable:DTAccountTableName];
        if (self.accountModel) {
            NSLog(@"%@", self.accountModel.addTime);
            [DTSQL.store deleteObjectById:self.accountModel.addTime fromTable:DTAccountTableName];
        }
        if (self.createAccountSuccess) {
            self.createAccountSuccess([DTAccountModel yy_modelWithJSON:DTSQL.keyValueItems.lastObject.itemObject]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
