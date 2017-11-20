//
//  NSString+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

- (BOOL)validEmail;
- (BOOL)isValidPhoneNumber;

/// return a properly formatted string with the number of photos
+ (NSString *)numberOfPhotosForCount:(NSInteger)photoCount;

@end
