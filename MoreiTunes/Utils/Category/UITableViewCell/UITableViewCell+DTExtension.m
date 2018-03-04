//
//  UITableViewCell+DTExtension.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/21.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UITableViewCell+DTExtension.h"
#import <objc/runtime.h>

@implementation UITableViewCell (DTExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sys = class_getInstanceMethod(self, @selector(initWithStyle:reuseIdentifier:));
        Method my = class_getInstanceMethod(self, @selector(my_initWithStyle:reuseIdentifier:));
        method_exchangeImplementations(sys, my);
    });
}

- (id)my_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    UITableViewCell *cell = [self my_initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setCellINFO];
    return cell;
}

- (void)setCellINFO {
    
}

@end
