//
//  Salon+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Salon.h"
#import "EKNetworkingConstants.h"
#import "JoinSalonRequest.h"
#import "Professional+API.h"

#import <RestKit/RestKit.h>

typedef void (^SalonStaffFetchSuccessBlock)(NSArray <Professional *> *staffArray);
typedef void (^SalonJoinSuccessBlock)();
typedef void (^SalonJoinFetchSuccessBlock)(NSArray <JoinSalonRequest *> *joinRequests);
typedef void (^SalonErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Salon (API)

/// fName, lName, token, email, password, phone
+ (RKObjectMapping *)map1;

/// when queried by customer
+ (RKResponseDescriptor *)getStaffResponseDescriptor;

/// when queried by salon
+ (RKResponseDescriptor *)getCurrentStaffResponseDescriptor;

+ (RKResponseDescriptor *)getStaffJoinRequestsResponseDescriptor;

/// Called by customers on company profile to view professionals currently working in the salon being viewed 
+ (void)getStaffForSalon:(NSString *)salonID forCustomer:(NSString *)userToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

/// Called by salons to view the currently employed professionals
+ (void)getCurrentStaffForSalon:(NSString *)salonToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

+ (void)getJoinRequestsForSalon:(NSString *)salonID withBlock:(SalonJoinFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

+ (void)acceptJoinRequest:(NSString *)requestID forSalon:(NSString *)salonToken withBlock:(SalonJoinSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

+ (void)declineJoinRequest:(NSString *)requestID forSalon:(NSString *)salonToken withBlock:(SalonJoinSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

/// Remove a professional from Salon staff roster
+ (void)removeFromSalonStaffMember:(NSString *)professionalID forSalon:(NSString *)salonToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

@end
