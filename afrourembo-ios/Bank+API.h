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
#import "Salon.h"
#import "EKNetworkingConstants.h"

typedef void (^BanksListSuccessBlock)(NSArray *array);
typedef void (^ProfessionalBankPostSuccessBlock)(Professional *professional);
typedef void (^SalonBankInfoPostSuccessBlock)(Salon *salon);
typedef void (^BanksListErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Bank (API)

/// bankID, name
+ (RKObjectMapping *)map1;

/// bankId, fName, lName, accountNumber
+ (RKObjectMapping *)map2;

/// Maps the returned reponse from the GET vendor bookings call
+ (RKResponseDescriptor *)getBanksResponseDescriptor;

+ (RKResponseDescriptor *)professionalBankPostResponseDescriptor;
+ (RKResponseDescriptor *)salonBankPostResponseDescriptor;

+ (RKRequestDescriptor *)professionalBankInfoRequestDescriptor;

+ (void)getBanksListWithBlock:(BanksListSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock;

+ (void)postPaymentInfoForProfessional:(NSString*)token bank:(NSString *)bankId firstName:(NSString *)fName lastName:(NSString *)lName acountNumber:(NSString *)account  withBlock:(ProfessionalBankPostSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock;

+ (void)postPaymentInfoForSalon:(NSString*)token bank:(NSString *)bankId firstName:(NSString *)fName lastName:(NSString *)lName acountNumber:(NSString *)account  withBlock:(SalonBankInfoPostSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock;

@end
