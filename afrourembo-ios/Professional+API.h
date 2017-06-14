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

typedef void (^ProfessionalSignUpSuccessBlock)(Professional *professionalObj);
typedef void (^ProfessionalSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);
typedef void (^ProfessionalEditErrorBlock)(NSError *error, NSString *errorMessage);

@interface Professional (API)

/// fName, lName, token, email, password, phone
+ (RKObjectMapping *)map1;

/// fName, lName, email, password
+ (RKObjectMapping *)map2;

+ (RKRequestDescriptor *)professionalRegistrationRequestDescriptor;

+ (RKResponseDescriptor *)professionalRegistrationResponseDescriptor;

+ (void)signUpProfessional:(NSString *)email password:(NSString *)password  firstName:(NSString *)fName lastName:(NSString *)lName  withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

@end
