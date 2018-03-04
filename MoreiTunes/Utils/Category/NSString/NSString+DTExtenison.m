//
//  NSString+DTExtenison.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/22.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "NSString+DTExtenison.h"

@implementation NSString (DTExtenison)

+ (NSString *)repeat:(NSInteger)idx {
    NSArray <NSString *>*letters = @[@"A", @"B", @"C", @"D", @"E",
                                     @"F", @"G", @"H", @"I", @"J",
                                     @"L", @"M", @"N", @"O", @"P",
                                     @"Q", @"R", @"S", @"T", @"U",
                                     @"V", @"W", @"X", @"Y", @"Z"];
    NSInteger letterIDX = idx/26;
    NSString *str = @"";
    for (int i = 0; i < letterIDX+1; i ++) {
        str = [NSString stringWithFormat:@"%@%@", str, letters[idx-(idx/26*26)]];
    }
    return str;
}

@end
