//
//  EKSettings.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSettings.h"

static NSString * const kLoggedInCustomer   = @"afrourembo-loggedInCustomer";
static NSString * const kLoggedInVendor     = @"afrourembo-loggedInVendor";

@implementation EKSettings

#pragma mark - User

+ (BOOL)saveCustomer:(Customer *)customer {
    
    NSString *userJSONString = [customer convertToJSON];
    
    if ([JNKeychain saveValue:userJSONString forKey:kLoggedInCustomer]) {
        
        NSLog(@"Customer persisted!");
        return YES;
        
    } else {
        
        NSLog(@"Failed to save Customer!");
        return NO;
    }
}

+ (Customer *)getSavedCustomer {
    
    NSString *userJSONString = [JNKeychain loadValueForKey:kLoggedInCustomer];
    
    if (userJSONString && userJSONString.length > 0) {
        
        return [Customer customerFromJSON:userJSONString];
        
    } else {
        
        NSLog(@"Did NOT Retrieve any saved CUSTOMERs");
        
        return nil;
    }
}

+ (BOOL)deleteSavedCustomer {
    
    if ([JNKeychain deleteValueForKey:kLoggedInCustomer]) {
        
        [EKSettings destroySessionCookies];
        // [EKSettings deleteUserLocation];
        
        [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:@""];
        
        NSLog(@"Deleted value for key '%@'. User is now: %@", kLoggedInCustomer, [JNKeychain loadValueForKey:kLoggedInCustomer]);
        return YES;
        
    } else {
        NSLog(@"Failed to delete!");
        return NO;
    }
}

+ (BOOL)updateSavedCustomer:(Customer *)updatedCustomer {
    
    Customer *oldUser = [EKSettings getSavedCustomer];
    
    Customer *userToPersist = [Customer updateCustomer:oldUser from:updatedCustomer];
    
    NSString *userJSONString = [userToPersist convertToJSON];
    
    if ([JNKeychain saveValue:userJSONString forKey:kLoggedInCustomer]) {
        
        NSLog(@"Customer updated and persisted!");
        return YES;
        
    } else {
        
        NSLog(@"Failed to update and persist Customer!");
        return NO;
    }
    
    return NO;
}

#pragma mark - Vendors

+ (BOOL)saveVendor {
    
    if ([JNKeychain saveValue:@1 forKey:kLoggedInVendor]) {
        NSLog(@"VENDOR PERSISTED!!!!");
        return YES;
    } else {
        NSLog(@"Failed to persist VENDOR");
        return NO;
    }
}

+ (BOOL)getVendor {
    
    NSNumber *vendor = [JNKeychain loadValueForKey:kLoggedInVendor];

    return [vendor isEqualToNumber:@1] ? YES : NO;
}

+ (BOOL)deleteVendor {
    
    if ([JNKeychain saveValue:@0 forKey:kLoggedInVendor]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Helpers

+ (void)saveToUserDefaultsValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (id)getFromUserDefaultsValueForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:key];
}

+ (void)destroySessionCookies {
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSLog(@"COOKIE: %@", cookie);
        [cookieStorage deleteCookie:cookie];
    }
}

@end
