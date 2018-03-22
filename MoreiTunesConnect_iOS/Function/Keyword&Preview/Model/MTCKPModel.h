//
//  MTCKPModel.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTCKPDetailsModel;//详情<简介、关键词、更新信息>
@class MTCKPINFOModel;//用于二级内的信息

@interface MTCKPModel : NSObject

/** 版权 */
psx(MTCKPINFOModel, copyright);

/** 重要信息 */
psx(MTCKPINFOModel, details);

@end

@interface MTCKPDetailsModel : NSObject

/** 简介 */
psx(MTCKPINFOModel, des);

/** 预览图 */
psx(MTCKPINFOModel, displayFamilies);

/** 关键词 */
psx(MTCKPINFOModel, keywords);

/** 更新信息 */
psx(MTCKPINFOModel, releaseNotes);

@end

@interface MTCKPINFOModel : NSObject

/** 主题内容 */
pax(id, value);

@end
