//
//  Dashboard+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/6/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Dashboard+API.h"

@implementation Dashboard (API)

#pragma mark - Mappings

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Dashboard class]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"itemId"}];
    
    [mapping addAttributeMappingsFromArray:@[@"bookingId", @"currency", @"price", @"startDate", @"endDate", @"service", @"customerId", @"fName", @"lName", @"phone", @"email"]];
    
    return mapping;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)getDashboardResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Dashboard map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kProfessionalDashboardAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)getDashboardOfVendor:(NSString *)userToken withBlock:(DashboardSuccessBlock)successBlock withErrors:(DashboardErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kProfessionalDashboardAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Vendor Dashboard !!");
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
