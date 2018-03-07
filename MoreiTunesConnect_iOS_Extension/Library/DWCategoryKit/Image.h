//
//  Image.h
//  tets
//
//  Created by Dwang on 2018/2/24.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Image_h
#define Image_h

/** 设置图片 */
#define UIImageName(imgName) [UIImage imageNamed:imgName]

/** 通过路径加载图片资源 */
#define UIImageWithFile(fileName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]

#endif /* Image_h */
