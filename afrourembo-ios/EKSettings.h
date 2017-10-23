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
#import "Professional+Helpers.h"
#import "Salon+Helpers.h"

@interface EKSettings : NSObject

+ (BOOL)saveCustomer:(Customer *)customer;
+ (Customer *)getSavedCustomer;
+ (BOOL)deleteSavedCustomer;
+ (BOOL)updateSavedCustomer:(Customer *)updatedCustomer;
+ (void)deleteBookingsForCustomer:(Customer *)savedCustomer;

+ (BOOL)saveVendor:(Professional*)professional;
+ (Professional *)getSavedVendor;
+ (BOOL)deleteSavedVendor;
+ (BOOL)updateSavedProfessional:(Professional *)updatedProfessional;

+ (BOOL)saveSalon:(Salon *)salon;
+ (Salon *)getSavedSalon;
+ (BOOL)deleteSavedSalon;
+ (BOOL)updateSavedSalon:(Salon *)updatedSalon;

+ (void)saveToUserDefaultsValue:(id)value forKey:(NSString *)key;
+ (id)getFromUserDefaultsValueForKey:(NSString *)key;
+ (void)destroySessionCookies;

@end
