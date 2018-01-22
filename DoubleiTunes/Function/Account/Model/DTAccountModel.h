//
//  DTAccountModel.h
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTAccountModel : NSObject

/** Apple ID邮箱📮 */
@property(nonatomic, copy) NSString *mail;

/** 密码(本地存储使用aes加密)🐱 */
@property(nonatomic, copy) NSString *password;

/** 备注📒 */
@property(nonatomic, copy) NSString *note;

/** 编辑账号时间⌚️ */
@property(nonatomic, copy) NSString *addTime;

@end
