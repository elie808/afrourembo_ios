//
//  Customer+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Customer.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^CustomerSignUpSuccessBlock)(Customer *customerObj);
typedef void (^CustomerSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Customer (API)

/// email, password
+ (RKObjectMapping *)map1;

/// Maps the returned reponse from the POST Sign Up call
+ (RKResponseDescriptor *)userRegistrationResponseDescriptor;

/// Maps the returned reponse from the POST Login call
+ (RKResponseDescriptor *)userLoginResponseDescriptor;

/// Maps the REQUEST for the POST call
+ (RKRequestDescriptor *)userRegistrationRequestDescriptor;

/**
 Info here
 
 @param email The user's email address
 @param successBlock Server will return the user's phone number
 @param errorBlock Server error logging
 */
+ (void)signUpCustomer:(NSString *)email password:(NSString *)password withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)loginCustomer:(NSString *)email password:(NSString *)password withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

@end
