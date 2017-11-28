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

#pragma mark - Requests

+ (RKRequestDescriptor *)postReviewsRequestDescriptor {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[ClientBooking class]];
    [mapping addAttributeMappingsFromArray:@[@"bookingId", @"review", @"rating"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"serviceIdInBooking" : @"serviceId"}];
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[mapping inverseMapping]
                                    objectClass:[ClientBooking class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
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

+ (RKResponseDescriptor *)postReviewsResponseDescriptor {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[ClientBooking class]];
    [mapping addAttributeMappingsFromArray:@[@"bookingId", @"review", @"rating"]];
    [mapping addAttributeMappingsFromDictionary:@{@"serviceIdInBooking" : @"serviceId"}];
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:mapping
                                      method:RKRequestMethodGET
                                      pathPattern:kUserPOSTReviewsAPIPath
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

+ (void)postReviewForBooking:(NSString *)bookingID withService:(NSString *)currentBookingID rating:(NSNumber *)rating andReview:(NSString *)review forUser:(NSString *)userToken withBlock:(ReviewPostSuccessBlock)successBlock withErrors:(ReviewErrorBlock)errorBlock {
    
    ClientBooking *reviewObj = [ClientBooking new];
    reviewObj.bookingId = bookingID;
    reviewObj.serviceId = currentBookingID;
    reviewObj.rating = rating;
    reviewObj.review = review;
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    [[RKObjectManager sharedManager] postObject:reviewObj
                                           path:kUserPOSTReviewsAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

                                            successBlock(nil);
                                            
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
