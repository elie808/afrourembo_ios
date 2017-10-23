//
//  ProfessionalInfo+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfessionalInfo.h"
#import "Professional.h"
#import "Professional+API.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^ProfessionalSignUpSuccessBlock)(Professional *professionalObj);
typedef void (^ProfessionalSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface ProfessionalInfo (API)

+ (RKRequestDescriptor *)professionalInfoRequestDescriptor;

+ (RKResponseDescriptor *)professionalInfoResponseDescriptor;

+ (void)postProInfo:(NSString *)businessName address:(NSString *)address longitude:(NSNumber *)longitude lattitude:(NSNumber *)latitude andToken:(NSString*)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock;

@end
