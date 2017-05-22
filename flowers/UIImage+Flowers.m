//
//  UIImage+Flowers.m
//  flowers
//
//  Created by iOS Developer on 16.05.17.
//  Copyright © 2017 Maksim Kis. All rights reserved.
//

#import "UIImage+Flowers.h"

@implementation UIImage (Flowers)

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
