//
//  NSString+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

- (BOOL)validEmail {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:self] == NO) {

        return NO;
    }
    
    return YES;
}

- (BOOL)isValidPhoneNumber {
    
    // Check if 53/54/56 exist as 1 piece
    // then check that the remaining 7 numbers range from 0-9
    // OR all conditions together using |
    
    // NSString *phoneRegex = @"(53){1}[0-9]{7}|(54){1}[0-9]{7}|(56){1}[0-9]{7}";
    
    NSString *phoneRegex = @"[0-9]{10}";
    
    NSPredicate *testPhoneEN = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [testPhoneEN evaluateWithObject:self];
}

+ (NSString *)numberOfPhotosForCount:(NSInteger)photoCount {
    
    if ( (int)photoCount == 1) {
        
        return [NSString stringWithFormat:@"%d photo", (int)photoCount];
        
    } else if (photoCount == 0){
    
        return @"No photos";
        
    } else {
        
        return [NSString stringWithFormat:@"%d photos", (int)photoCount];
    }
}

- (NSString *)cleanupURL {
    
    return [[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
}

@end
