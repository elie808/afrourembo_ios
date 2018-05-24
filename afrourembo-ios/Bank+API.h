//
//  Bank+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/16/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "Bank.h"

#import <RestKit/RestKit.h>

#import "Professional+API.h"
#import "EKNetworkingConstants.h"

typedef void (^BanksListSuccessBlock)(NSArray *array);
typedef void (^ProfessionalBankPostSuccessBlock)(Professional *professional);
typedef void (^BanksListErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Bank (API)

/// bankID, name
+ (RKObjectMapping *)map1;

/// bankId, fName, lName, accountNumber
+ (RKObjectMapping *)map2;

/// Maps the returned reponse from the GET vendor bookings call
+ (RKResponseDescriptor *)getBanksResponseDescriptor;

+ (RKResponseDescriptor *)professionalBankPostResponseDescriptor;

+ (RKRequestDescriptor *)professionalBankInfoRequestDescriptor;

/**
 Returns all the booked time slots of a professional
 
 @param successBlock Server will return the booked time slots
 @param errorBlock Server error logging
 */
+ (void)getBanksListWithBlock:(BanksListSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock;

+ (void)postPaymentInfoForProfessional:(NSString*)token bank:(NSString *)bankId firstName:(NSString *)fName lastName:(NSString *)lName acountNumber:(NSString *)account  withBlock:(ProfessionalBankPostSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock;

@end
