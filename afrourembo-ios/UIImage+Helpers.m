//
//  UIImage+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Helpers)

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
