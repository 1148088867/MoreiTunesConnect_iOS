//
//  UIImage+Extenison.m
//  test
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UIImage+DWExtenison.h"
#import "DWOUTPUT.h"

@implementation UIImage (DWExtension)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageOriginalWithFilterType:(DWFilterType)filterType {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:[self filterType:filterType]];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

- (UIImage *)imageOriginalWithBlurType:(DWBlurType)blurType radius:(NSInteger)radius {
    NSString *name = [self blurType:blurType];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter;
    if (name.length != 0) {
        filter = [CIFilter filterWithName:name];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![name isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return nil;
    }
}

- (UIImage *)imageOriginalWithsaturation:(CGFloat)saturation
                              brightness:(CGFloat)brightness
                                contrast:(CGFloat)contrast {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];// 0.0 ~ 1.0
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

- (NSString *)filterType:(DWFilterType)filterType {
    NSString *name = @"";
    switch (filterType) {
        case 0:
            name = @"CIPhotoEffectInstant";
            break;
        case 1:
            name = @"CIPhotoEffectNoir";
            break;
        case 2:
            name = @"CIPhotoEffectTonal";
            break;
        case 3:
            name = @"CIPhotoEffectTransfer";
            break;
        case 4:
            name = @"CIPhotoEffectMono";
            break;
        case 5:
            name = @"CIPhotoEffectFade";
            break;
        case 6:
            name = @"CIPhotoEffectProcess";
            break;
        case 7:
            name = @"CIPhotoEffectChrome";
            break;
        default:
            break;
    }
    return name;
}

- (NSString *)blurType:(DWBlurType)blurType {
    NSString *name = @"";
    switch (blurType) {
        case 0:
            name = @"CIGaussianBlur";
            break;
        case 1:
            name = @"CIBoxBlur";
            break;
        case 2:
            name = @"CIDiscBlur";
            break;
        case 3:
            name = @"CIMedianFilter";
            break;
        case 4:
            name = @"CIMotionBlur";
            break;
        default:
            break;
    }
    if (IOS_VERSION >= 9) {
        return name;
    }
    return @"CIGaussianBlur";
}

@end

