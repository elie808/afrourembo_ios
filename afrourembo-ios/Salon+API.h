//
//  Salon+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Salon.h"
#import "EKNetworkingConstants.h"
#import "Professional+API.h"

#import <RestKit/RestKit.h>

typedef void (^SalonStaffFetchSuccessBlock)(NSArray <Professional *> *staffArray);
typedef void (^SalonErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Salon (API)

/// fName, lName, token, email, password, phone
+ (RKObjectMapping *)map1;

+ (RKResponseDescriptor *)getStaffResponseDescriptor;

+ (void)getStaffForSalon:(NSString *)salonID forCustomer:(NSString *)userToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

@end
