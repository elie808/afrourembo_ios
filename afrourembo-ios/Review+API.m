//
//  Review+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Review+API.h"

@implementation Review (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Review class]];
    [mapping addAttributeMappingsFromArray:@[@"reviewerFirstName", @"reviewerLastName", @"reviewerProfilePicture", @"serviceName", @"review", @"date", @"rating", @"actorId", @"actorType"]];
    
    return mapping;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)getReviewsResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Review map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kUserReviewsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)getReviewsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType withToken:(NSString *)userToken withBlock:(ReviewFetchSuccessBlock)successBlock withErrors:(ReviewErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"user/reviews/%@?type=%@", vendorID, vendorType]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching REVIEWS !!!");
                                                  successBlock(mappingResult.array);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  // exctract error message
                                                  NSDictionary *myDic = [NSJSONSerialization
                                                                         JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                         options:NSJSONReadingMutableLeaves
                                                                         error:nil];
                                                  
                                                  NSString *errorMessage = [myDic valueForKey:@"message"];
                                                  
                                                  NSNumber *statusCodeNumber = [myDic valueForKey:@"statusCode"];
                                                  
                                                  errorBlock(error, errorMessage, [statusCodeNumber integerValue]);
                                              }];
}

@end
