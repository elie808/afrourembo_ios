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

typedef void (^ProfessionalSignUpSuccessBlock)(Professional *professionalObj);
typedef void (^ProfessionalSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);
typedef void (^ProfessionalEditErrorBlock)(NSError *error, NSString *errorMessage);

@interface Professional (API)

/// fName, lName, token, email, password, phone - Used for generic mapping
+ (RKObjectMapping *)map1;

/// fName, lName, email, password - Used for Sign UP
+ (RKObjectMapping *)map2;

+ (RKRequestDescriptor *)professionalRegistrationRequestDescriptor;

+ (RKResponseDescriptor *)professionalRegistrationResponseDescriptor;

+ (RKResponseDescriptor *)professionalResetPassResponseDescriptor;

+ (void)signUpProfessional:(NSString *)email password:(NSString *)password  firstName:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone  withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

@end
