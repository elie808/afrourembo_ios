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
static NSString * const kLoggedInSalon      = @"afrourembo-loggedInSalon";

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

+ (void)deleteBookingsForCustomer:(Customer *)savedCustomer {
    
    if ([EKSettings getSavedCustomer] && [EKSettings getSavedCustomer].email.length > 0) {
     
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"bookingOwner = %@", [EKSettings getSavedCustomer].email];
        RLMResults<Booking*> *bookings = [Booking objectsWithPredicate:pred];
        
        [[RLMRealm defaultRealm] beginWriteTransaction];
        for (Booking *bookingObj in bookings) {
            
            [[RLMRealm defaultRealm] deleteObject:bookingObj.reservation];
            [[RLMRealm defaultRealm] deleteObject:bookingObj];
        }
        
        [[RLMRealm defaultRealm] commitWriteTransaction];
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

+ (BOOL)saveVendor:(Professional*)professional {
    
    NSString *userJSONString = [professional convertToJSON];
    
    if ([JNKeychain saveValue:userJSONString forKey:kLoggedInVendor]) {
        
        NSLog(@"VENDOR PERSISTED!!!!");
        return YES;
        
    } else {
        
        NSLog(@"Failed to persist VENDOR");
        return NO;
    }
}

+ (Professional *)getSavedVendor {
    
    NSString *proJSONString = [JNKeychain loadValueForKey:kLoggedInVendor];
    
    if (proJSONString && proJSONString.length > 0) {
        
        return [Professional professionalFromJSON:proJSONString];
        
    } else {
        
        NSLog(@"Did NOT Retrieve any saved Vendors");
        
        return nil;
    }
}

+ (BOOL)deleteSavedVendor {
    
    if ([JNKeychain deleteValueForKey:kLoggedInVendor]) {
        
        [EKSettings destroySessionCookies];
        // [EKSettings deleteUserLocation];
        
        [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:@""];
        
        NSLog(@"Deleted value for key '%@'. User is now: %@", kLoggedInVendor, [JNKeychain loadValueForKey:kLoggedInVendor]);
        return YES;
        
    } else {
        
        NSLog(@"Failed to delete vendor!");
        return NO;
    }
}

+ (BOOL)updateSavedProfessional:(Professional *)updatedProfessional {
    
    Professional *oldUser = [EKSettings getSavedVendor];
    
    Professional *userToPersist = [Professional updateProfessional:oldUser from:updatedProfessional];
    
    NSString *userJSONString = [userToPersist convertToJSON];
    
    if ([JNKeychain saveValue:userJSONString forKey:kLoggedInVendor]) {
        
        NSLog(@"Vendor updated and persisted!");
        return YES;
        
    } else {
        
        NSLog(@"Failed to update and persist Vendor!");
        return NO;
    }
    
    return NO;
}

#pragma mark - Salon

+ (BOOL)saveSalon:(Salon *)salon {
    
    NSString *userJSONString = [salon convertToJSON];
    
    if ([JNKeychain saveValue:userJSONString forKey:kLoggedInSalon]) {
        
        NSLog(@"SALON PERSISTED!!!!");
        return YES;
        
    } else {
        
        NSLog(@"Failed to persist SALON");
        return NO;
    }
}

+ (Salon *)getSavedSalon {
    
    NSString *JSONString = [JNKeychain loadValueForKey:kLoggedInSalon];
    
    if (JSONString && JSONString.length > 0) {
        
        return [Salon salonFromJSON:JSONString];
        
    } else {
        
        NSLog(@"Did NOT Retrieve any saved Vendors");
        
        return nil;
    }
}

+ (BOOL)deleteSavedSalon {
    
    if ([JNKeychain deleteValueForKey:kLoggedInSalon]) {
        
        [EKSettings destroySessionCookies];
        // [EKSettings deleteUserLocation];
        
        [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:@""];
        
        NSLog(@"Deleted value for key '%@'. User is now: %@", kLoggedInVendor, [JNKeychain loadValueForKey:kLoggedInSalon]);
        return YES;
        
    } else {
        
        NSLog(@"Failed to delete vendor!");
        return NO;
    }
}

+ (BOOL)updateSavedSalon:(Salon *)updatedSalon {
    
    Salon *oldUser = [EKSettings getSavedSalon];
    
    Salon *userToPersist = [Salon updateSalon:oldUser from:updatedSalon];
    
    NSString *userJSONString = [userToPersist convertToJSON];
    
    if ([JNKeychain saveValue:userJSONString forKey:kLoggedInSalon]) {
        
        NSLog(@"Salon updated and persisted!");
        return YES;
        
    } else {
        
        NSLog(@"Failed to update and persist Salon!");
        return NO;
    }
    
    return NO;
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
