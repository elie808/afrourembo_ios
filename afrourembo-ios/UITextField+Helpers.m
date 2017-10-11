//
//  UITextField+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "UITextField+Helpers.h"

@implementation UITextField (Helpers)

- (NSString *)trimWhiteSpace:(NSString *)text {
    
    NSString *spaceFreeStr = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *dashFreeStr = [spaceFreeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return dashFreeStr;
}

@end
