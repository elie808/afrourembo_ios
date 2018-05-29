//
//  StaffPayment+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "StaffPayment+API.h"

@implementation StaffPayment (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[StaffPayment class]];
    [mapping addAttributeMappingsFromArray:@[@"price", @"currency"]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"professional"
                                                                            toKeyPath:@"professional"
                                                                          withMapping:[Professional map1]]];

    return mapping;
}

#pragma mark - Requests

#pragma mark - Response

+ (RKResponseDescriptor *)staffPaymentResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[StaffPayment map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kSalonStaffPaymentAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
    
}

#pragma mark - APIs

+ (void)getStaffPaymentDetailsFrom:(NSString *)startDate to:(NSString *)endDate forSalon:(NSString *)token withBlock:(StaffPaymentSuccessBlock)successBlock withErrors:(StaffPaymentErrorBlock)errorBlock {
    
    //salon/staff/payments
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];

    NSString *url;
    if (startDate.length > 0 && endDate.length > 0) {
        url = [NSString stringWithFormat:@"%@?from=%@&to=%@", kSalonStaffPaymentAPIPath, startDate, endDate];
    } else {
        url = kSalonStaffPaymentAPIPath;
    }
    
    [[RKObjectManager sharedManager] getObjectsAtPath:url
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success getting Staff Payment Info!!");
                                                  successBlock(mappingResult.array);
                                                  
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  if (operation.HTTPRequestOperation.responseData) {
                                                      
                                                      // exctract error message
                                                      NSDictionary *myDic = [NSJSONSerialization
                                                                             JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                             options:NSJSONReadingMutableLeaves
                                                                             error:nil];
                                                      
                                                      NSString *errorMessage = [myDic valueForKey:@"message"];
                                                      
                                                      NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
                                                      
                                                      NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                                      errorBlock(error, errorMessage, [statusCode integerValue]);
                                                      
                                                  } else {
                                                      
                                                      errorBlock(error, @"You are not connected to the internet.", 0);
                                                  }
                                              }];    
}

@end
