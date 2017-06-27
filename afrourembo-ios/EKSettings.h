//
//  EKSettings.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer+Helpers.h"
#import <RestKit/RestKit.h>
#import <JNKeychain/JNKeychain.h>

@interface EKSettings : NSObject

+ (BOOL)saveCustomer:(Customer *)customer;
+ (Customer *)getSavedCustomer;
+ (BOOL)deleteSavedCustomer;
+ (BOOL)updateSavedCustomer:(Customer *)updatedCustomer;

+ (void)saveToUserDefaultsValue:(id)value forKey:(NSString *)key;
+ (id)getFromUserDefaultsValueForKey:(NSString *)key;
+ (void)destroySessionCookies;

@end
