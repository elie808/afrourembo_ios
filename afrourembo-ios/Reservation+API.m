//
//  Reservation+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Reservation+API.h"

@implementation Reservation (API)

#pragma mark - Mappings

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Reservation class]];
    [mapping addAttributeMappingsFromArray:@[@""]];
    
    return mapping;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)reservationsResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Reservation map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kUserReservationsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)getUserReservations:(NSString *)userToken withBlock:(UserReservationSuccessBlock)successBlock withErrors:(UserReservationErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kUserReservationsAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching User Reservations !!!");
                                                  successBlock(mappingResult.array);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
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
