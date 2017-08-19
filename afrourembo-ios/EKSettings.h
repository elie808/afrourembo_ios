//
//  EKSettings.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>
#import <RestKit/RestKit.h>
#import <JNKeychain/JNKeychain.h>

#import "Booking.h"
#import "Customer+Helpers.h"

@interface EKSettings : NSObject

+ (BOOL)saveCustomer:(Customer *)customer;
+ (Customer *)getSavedCustomer;
+ (BOOL)deleteSavedCustomer;
+ (BOOL)updateSavedCustomer:(Customer *)updatedCustomer;
+ (void)deleteBookingsForCustomer:(Customer *)savedCustomer;

//TODO: Flesh out into grown up methods
+ (BOOL)saveVendor;
+ (BOOL)getVendor;
+ (BOOL)deleteVendor;

+ (void)saveToUserDefaultsValue:(id)value forKey:(NSString *)key;
+ (id)getFromUserDefaultsValueForKey:(NSString *)key;
+ (void)destroySessionCookies;

@end
