//
//  StaffPayment+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "StaffPayment.h"
#import "Professional+API.h"
#import "EKNetworkingConstants.h"
#import <RestKit/RestKit.h>

typedef void (^StaffPaymentSuccessBlock)(NSArray <StaffPayment*> *staffPaymentArray);
typedef void (^StaffPaymentErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface StaffPayment (API)

+ (RKObjectMapping *)map1;

+ (RKResponseDescriptor *)staffPaymentResponseDescriptor;

+ (void)getStaffPaymentDetailsFrom:(NSString *)startDate to:(NSString *)endDate forSalon:(NSString *)token withBlock:(StaffPaymentSuccessBlock)successBlock withErrors:(StaffPaymentErrorBlock)errorBlock;

@end
