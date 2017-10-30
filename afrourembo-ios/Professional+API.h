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
#import "Customer+API.h"

typedef void (^ProfessionalSignUpSuccessBlock)(Professional *professionalObj);
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

+ (RKResponseDescriptor *)professionalProfileResponseDescriptor;

+ (void)signUpProfessional:(NSString *)email password:(NSString *)password  firstName:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone  withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// GET list of professional's clients
+ (void)getClients:(NSString *)token withBlock:(ProfessionalClientsSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

/// GET professional's profile
+ (void)getProfile:(NSString *)profID withCustomerToken:(NSString *)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

@end
