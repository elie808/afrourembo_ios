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

/// Return a properly formatted string with the number of photos
+ (NSString *)numberOfPhotosForCount:(NSInteger)photoCount;

/// Remove spaces then & chars from URL. Do it this ghetto way because fucking Apple's method misses out on some special chars...
- (NSString *)cleanupURL;

@end
