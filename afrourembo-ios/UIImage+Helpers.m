//
//  UIImage+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Helpers)

+ (NSData *)compressImage:(UIImage *)myImage toSize:(int)fileSizeInMBs {
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = fileSizeInMBs * 1024 * 1024; // size in bytes
    
    NSData *imageData = UIImageJPEGRepresentation(myImage, compression);
    
    NSLog(@"Original image size: %@",[NSByteCountFormatter stringFromByteCount:imageData.length
                                                                    countStyle:NSByteCountFormatterCountStyleFile]);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(myImage, compression);
    }
    
    NSLog(@"Resized image size: %@",[NSByteCountFormatter stringFromByteCount:imageData.length
                                                                   countStyle:NSByteCountFormatterCountStyleFile]);
    
    return imageData;
}

+ (UIImage *)imageForStars:(NSNumber *)numberOfStars {
    
    switch ([numberOfStars integerValue]) {
            
        case 0: return [UIImage imageNamed:@"0star"]; break;
        case 1: return [UIImage imageNamed:@"1star"]; break;
        case 2: return [UIImage imageNamed:@"2star"]; break;
        case 3: return [UIImage imageNamed:@"3star"]; break;
        case 4: return [UIImage imageNamed:@"4star"]; break;
        case 5: return [UIImage imageNamed:@"5star"]; break;
            
        default: return [UIImage imageNamed:@"0star"]; break;
    }
}

@end
