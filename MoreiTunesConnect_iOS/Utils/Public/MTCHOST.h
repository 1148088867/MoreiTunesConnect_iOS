//
//  MTCHOST.h
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef MTCHOST_h
#define MTCHOST_h

/** iTunes登录 */
#define MTCiTunesLogin @"https://idmsa.apple.com/appleauth/auth/signin"

/** iTunesApps */
#define MTCiTunesApps @"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/manageyourapps/summary/v2"

/** iTunes解决中心 */
#define MTCiTunesResolutionCenter(appid) [NSString stringWithFormat:@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/%@/platforms/ios/resolutionCenter", appid]

/** iTunes版本审核 */
#define MTCiTunesAppVerison(appid, versionid) [NSString stringWithFormat:@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/%@/platforms/ios/versions/%@", appid, versionid]

/** iTunes预览图下载 */
#define MTCiTunesAppPreview(imgUrl, size) [NSString stringWithFormat:@"https://is1-ssl.mzstatic.com/image/thumb/%@/%@x%@bb.jpg", imgUrl, size, size]

#endif /* MTCHOST_h */
