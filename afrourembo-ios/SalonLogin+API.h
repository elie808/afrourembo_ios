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

typedef void (^SalonSignUpSuccessBlock)(Salon *salonObj);
typedef void (^SalonSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface SalonLogin (API)

/// email, password
+ (RKObjectMapping *)map1;

+ (RKRequestDescriptor *)salonLoginRequestDescriptor;

+ (RKResponseDescriptor *)salonLoginResponseDescriptor;

+ (void)loginSalon:(NSString *)email password:(NSString *)password withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock;

@end
