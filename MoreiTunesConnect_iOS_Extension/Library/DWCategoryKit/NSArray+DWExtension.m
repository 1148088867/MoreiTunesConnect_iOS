//
//  NSArray+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "NSArray+DWExtension.h"
#import <objc/runtime.h>

@implementation NSArray (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sys_Method = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method dw_Method = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(dw_objectAtIndex:));
        method_exchangeImplementations(sys_Method, dw_Method);
    });
}

- (id)dw_objectAtIndex:(NSInteger)idx {
    if (idx >= self.count) {
        NSAssert(NO, @"不可变数组越界");
        return nil;
    }
    return [self dw_objectAtIndex:idx];
}

@end
