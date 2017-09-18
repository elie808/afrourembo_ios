//
//  ProfessionalLogin+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfessionalLogin.h"
#import "Professional+API.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^ProfessionalSignUpSuccessBlock)(Professional *professionalObj);
typedef void (^ProfessionalSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface ProfessionalLogin (API)

/// email, password
+ (RKObjectMapping *)map1;

+ (RKRequestDescriptor *)professionalLoginRequestDescriptor;
+ (RKRequestDescriptor *)fbProfessionalRequestDescriptor;

+ (RKResponseDescriptor *)professionalLoginResponseDescriptor;
+ (RKResponseDescriptor *)fbProfessionalRegistrationResponseDescriptor;
+ (RKResponseDescriptor *)fbProfessionalLoginResponseDescriptor;

+ (void)loginProfessional:(NSString *)email password:(NSString *)password withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

+ (void)loginProfessionalWithFacebook:(NSString *)fbToken withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

+ (void)signUpProfessionalWithFacebook:(NSString *)fbToken withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

@end
