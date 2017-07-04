//
//  Explore+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Explore+API.h"

@implementation Explore (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Explore class]];
    [mapping addAttributeMappingsFromArray:@[@"professionals", @"salons"]];
    
    return mapping;
}

#pragma mark - Requests

#pragma mark - Responses

+ (RKResponseDescriptor *)exploreResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Explore map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kUserExploreAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)getExploreLocationsForUser:(NSString *)userToken WithBlock:(ExploreSuccessBlock)successBlock withErrors:(ExploreErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kUserExploreAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Explore!!");
                                                  successBlock([mappingResult.array firstObject]);
                                                  
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  // exctract error message
                                                  NSDictionary *myDic = [NSJSONSerialization
                                                                         JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                         options:NSJSONReadingMutableLeaves
                                                                         error:nil];
                                                  
                                                  NSString *errorMessage = [myDic valueForKey:@"message"];
                                                  
                                                  NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
                                                  
                                                  NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                                  errorBlock(error, errorMessage, [statusCode integerValue]);
                                              }];
}


@end
