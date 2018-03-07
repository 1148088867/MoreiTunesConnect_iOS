//
//  Property.h
//  test
//
//  Created by Dwang on 2018/2/24.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Property_h
#define Property_h

/** copy */
#define pcx(type, name) @property(nonatomic, copy) type *name

/** copy and readonly */
#define pcrx(type, name) @property(nonatomic, copy, readonly) type *name

/** assign */
#define pax(type, name) @property(nonatomic, assign) type name

/** assign and readonly */
#define parx(type, name) @property(nonatomic, assign, readonly) type name

/** weak */
#define pwx(type, name) @property(nonatomic, weak) type *name

/** weak and readonly */
#define pwrx(type, name) @property(nonatomic, weak, readonly) type *name

/** strong */
#define psx(type, name) @property(nonatomic, strong) type *name

/** strong and readonly */
#define psrx(type, name) @property(nonatomic, strong, readonly) type *name

/** property创建block */
#define pblockx(returnType, blockName, parameterTypes) @property(nonatomic, copy) returnType (^blockName)(parameterTypes)

/** 创建block，搭配blockpx使用 */
#define blockx(returnType, blockName, arguments) typedef returnType (^blockName)(arguments)
/** 与blockx搭配使用 */
#define blockpx(type, name) @property(nonatomic, copy) type name

#endif /* Property_h */
