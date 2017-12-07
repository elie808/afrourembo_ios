//
//  Professional+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Professional.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"
#import "ResetPassword.h"
#import "Salon.h"
#import "Salon+API.h"
#import "Customer+API.h"

typedef void (^ProfessionalSignUpSuccessBlock)(Professional *professionalObj);
typedef void (^ProfessionalSalonJoinSuccessBlock)(Salon *salonObj);
typedef void (^ProfessionalClientsSuccessBlock)(NSArray<Customer *> *customersArray);
typedef void (^ProfessionalSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);
typedef void (^ProfessionalEditErrorBlock)(NSError *error, NSString *errorMessage);

@interface Professional (API)

/// fName, lName, token, email, password, phone - Used for generic mapping
+ (RKObjectMapping *)map1;

/// fName, lName, email, password - Used for Sign UP
+ (RKObjectMapping *)map2;

+ (RKResponseDescriptor *)professionalClientsResponseDescriptor;

+ (RKRequestDescriptor *)professionalRegistrationRequestDescriptor;

+ (RKResponseDescriptor *)professionalRegistrationResponseDescriptor;

+ (RKResponseDescriptor *)professionalResetPassResponseDescriptor;

/// Professional profile, requested by a Customer
+ (RKResponseDescriptor *)professionalProfileResponseDescriptor;

/// Professional profile, requested by the professional
+ (RKResponseDescriptor *)getProfessionalProfileResponseDescriptor;

/// Update Professional profile
+ (RKResponseDescriptor *)putProfessionalProfileResponseDescriptor;

/// Request to join a salon
+ (RKResponseDescriptor *)postProfessionalSalonJoinResponseDescriptor;

/// Get salon's clients
+ (RKResponseDescriptor *)getSalonClientsResponseDescriptor;

+ (void)signUpProfessional:(NSString *)email password:(NSString *)password  firstName:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone  withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// GET list of professional's clients
+ (void)getClientsForProfessional:(NSString *)token withBlock:(ProfessionalClientsSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// GET list of salon's clients
+ (void)getClientsForSalon:(NSString *)token withBlock:(ProfessionalClientsSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// GET professional's profile from a Customer's account
+ (void)getProfile:(NSString *)profID withCustomerToken:(NSString *)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// GET professional's profile from a professional's account
+ (void)getProfileForProfessional:(NSString *)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// PUT professional's profile to update it
+ (void)udpateProfile:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone about:(NSString *)aboutText withToken:(NSString *)userToken withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// POST request to join a Salon. Has to be approved by Salon
+ (void)joinSalon:(NSString *)salonID withToken:(NSString *)token withBlock:(ProfessionalSalonJoinSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

@end
