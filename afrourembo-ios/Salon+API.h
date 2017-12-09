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

typedef void (^SalonSignUpSuccessBlock)(Salon *salonObj);
typedef void (^SalonStaffFetchSuccessBlock)(NSArray <Professional *> *staffArray);
typedef void (^SalonJoinSuccessBlock)();
typedef void (^SalonJoinFetchSuccessBlock)(NSArray <JoinSalonRequest *> *joinRequests);
typedef void (^SalonErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Salon (API)

/// fName, lName, token, email, password, phone
+ (RKObjectMapping *)map1;

/// email, password, fName, lName, phone
+ (RKObjectMapping *)map2;

/// name, longitude, latitude, address
+ (RKObjectMapping *)map3;


/// salon sign up request
+ (RKRequestDescriptor *)salonRegistrationRequestDescriptor;

/// salon name, address and info on sign up
+ (RKRequestDescriptor *)salonInfoRequestDescriptor;


+ (RKResponseDescriptor *)salonRegistrationResponseDescriptor;

/// salon name, address, info on sign up
+ (RKResponseDescriptor *)postSalonInfoResponseDescriptor;

/// when queried by customer
+ (RKResponseDescriptor *)getStaffResponseDescriptor;

/// when queried by salon
+ (RKResponseDescriptor *)getCurrentStaffResponseDescriptor;

+ (RKResponseDescriptor *)getStaffJoinRequestsResponseDescriptor;

+ (void)signUpSalon:(NSString *)email password:(NSString *)password firstName:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

/// Set salon's info; name, address, potentially user's role in salon at some point...
+ (void)postSalonInfo:(NSString *)businessName address:(NSString *)address longitude:(NSNumber *)longitude lattitude:(NSNumber *)latitude andToken:(NSString*)token withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock;

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
