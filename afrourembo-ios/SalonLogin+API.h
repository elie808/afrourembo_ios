//
//  SalonLogin+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "SalonLogin.h"
#import "Salon.h"
#import "Salon+API.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"
#import "ResetPassword+API.h"

typedef void (^SalonResetCodeSuccessBlock)(void);
typedef void (^SalonSignUpSuccessBlock)(Salon *salonObj);
typedef void (^SalonSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface SalonLogin (API)

/// email, password
+ (RKObjectMapping *)map1;

+ (RKRequestDescriptor *)salonFBRequestDescriptor;
+ (RKRequestDescriptor *)salonLoginRequestDescriptor;

+ (RKResponseDescriptor *)salonFBRegistrationResponseDescriptor;

+ (RKResponseDescriptor *)salonLoginResponseDescriptor;

+ (RKResponseDescriptor *)salonResetPassResponseDescriptor;

+ (void)loginSalon:(NSString *)email password:(NSString *)password withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock;

/**
 Send an SMS reset code when method returns succesfully, to be enterred for reseting password.
 
 @param phoneNumber The salon's phone number
 @param successBlock Server will return an empty response
 @param errorBlock Server error logging
 */
+ (void)getResetCodeForPhonenumber:(NSString *)phoneNumber withBlock:(SalonResetCodeSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock;

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock;

+ (void)signUpSalonWithFacebook:(NSString *)fbToken withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock;

@end
