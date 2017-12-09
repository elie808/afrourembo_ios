//
//  Salon+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Salon+API.h"

@implementation Salon (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Salon class]];
    [mapping addAttributeMappingsFromArray:@[@"token", @"fName", @"lName", @"email", @"profilePicture", @"name", @"phone", @"address", @"longitude", @"latitude"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"salonID"}];
    
    RKObjectMapping *portfolioMapping = [RKObjectMapping mappingForClass:[Pictures class]];
    [portfolioMapping addAttributeMappingsFromArray:@[@"picture"]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{@"_id" : @"pictureID"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"portfolio"
                                                                            toKeyPath:@"portfolio"
                                                                          withMapping:portfolioMapping]];
    
    return mapping;
}

+ (RKObjectMapping *)map2 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Salon class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"fName", @"lName", @"phone"]];
    
    return mapping;
}

+ (RKObjectMapping *)map3 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[SalonInfo class]];
    [mapping addAttributeMappingsFromArray:@[@"name", @"longitude", @"latitude", @"address"]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)salonRegistrationRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Salon map2] inverseMapping]
                                    objectClass:[Salon class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

+ (RKRequestDescriptor *)salonInfoRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Salon map3] inverseMapping]
                                    objectClass:[SalonInfo class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)salonRegistrationResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Salon map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kSalonRegisterAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)postSalonInfoResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Salon map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kSalonInfoAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)getStaffResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kSalonStaffAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)getStaffJoinRequestsResponseDescriptor {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[JoinSalonRequest class]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"joinID"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"professional"
                                                                            toKeyPath:@"professional"
                                                                          withMapping:[Professional map1]]];
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:mapping
                                      method:RKRequestMethodGET
                                      pathPattern:kSalonJoinRequestsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)getCurrentStaffResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kSalonCurrentStaffAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)signUpSalon:(NSString *)email password:(NSString *)password firstName:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    Salon *salon = [Salon new];
    
    salon.fName = fName;
    salon.lName = lName;
    salon.email = email;
    salon.password = password;
    salon.phone = phone;
    
    [[RKObjectManager sharedManager] postObject:salon
                                           path:kSalonRegisterAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            if (mappingResult.array.count > 0) {
                                                Salon *salonObj = [mappingResult.array firstObject];
                                                successBlock(salonObj);
                                            } else {
                                                successBlock(nil);
                                            }

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

+ (void)postSalonInfo:(NSString *)businessName address:(NSString *)address longitude:(NSNumber *)longitude lattitude:(NSNumber *)latitude andToken:(NSString*)token withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    SalonInfo *salonInfo = [SalonInfo new];
    salonInfo.name = businessName;
    salonInfo.longitude = longitude;
    salonInfo.latitude  = latitude;
    salonInfo.address   = address;
    
    [[RKObjectManager sharedManager] postObject:salonInfo
                                           path:kSalonInfoAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            if (mappingResult.array.count > 0) {
                                                
                                                Salon *salonObj = [mappingResult.array firstObject];
                                                successBlock(salonObj);
                                                
                                            } else {
                                                
                                                successBlock(nil);
                                            }

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

+ (void)getCurrentStaffForSalon:(NSString *)salonToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:salonToken];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kSalonCurrentStaffAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Staff !!!");
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

+ (void)getStaffForSalon:(NSString *)salonID forCustomer:(NSString *)userToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"salon/%@/professionals", salonID]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Staff !!!");
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

+ (void)getJoinRequestsForSalon:(NSString *)salonID withBlock:(SalonJoinFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:salonID];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kSalonJoinRequestsAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Joins Requests !!!");
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

+ (void)acceptJoinRequest:(NSString *)requestID forSalon:(NSString *)salonToken withBlock:(SalonJoinSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {

    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:salonToken];
    
    [[RKObjectManager sharedManager] putObject:nil
                                          path:[NSString stringWithFormat:@"%@/%@", kSalonJoinRequestsAPIPath, requestID]
                                    parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           
                                           NSLog(@"Success Accept Join Request !!");
                                           successBlock();
                                       }
                                       failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                           
                                           if (operation.HTTPRequestOperation.responseData) {
                                               
                                               // exctract error message
                                               NSDictionary *myDic = [NSJSONSerialization
                                                                      JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                      options:NSJSONReadingMutableLeaves
                                                                      error:nil];
                                               
                                               NSString *errorMessage = [myDic valueForKey:@"message"];
                                               NSNumber *errorCode = [myDic valueForKey:@"statusCode"];
                                               
                                               NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                               errorBlock(error, errorMessage, errorCode.integerValue);
                                               
                                           } else {
                                               
                                               errorBlock(error, @"You are not connected to the internet.", 0);
                                           }
                                       }];
}

+ (void)declineJoinRequest:(NSString *)requestID forSalon:(NSString *)salonToken withBlock:(SalonJoinSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:salonToken];

    [[RKObjectManager sharedManager] deleteObject:nil
                                             path:[NSString stringWithFormat:@"%@/%@", kSalonJoinRequestsAPIPath, requestID]
                                       parameters:nil
                                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              
                                              NSLog(@"Success Declining Join Request !!");
                                              successBlock();
                                              
                                          } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              
                                              if (operation.HTTPRequestOperation.responseData) {
                                                  
                                                  // exctract error message
                                                  NSDictionary *myDic = [NSJSONSerialization
                                                                         JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                         options:NSJSONReadingMutableLeaves
                                                                         error:nil];
                                                  
                                                  NSString *errorMessage = [myDic valueForKey:@"message"];
                                                  NSNumber *errorCode = [myDic valueForKey:@"statusCode"];
                                                  
                                                  NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                                  errorBlock(error, errorMessage, errorCode.integerValue);
                                                  
                                              } else {
                                                  
                                                  errorBlock(error, @"You are not connected to the internet.", 0);
                                              }
                                          }];
}

+ (void)removeFromSalonStaffMember:(NSString *)professionalID forSalon:(NSString *)salonToken withBlock:(SalonStaffFetchSuccessBlock)successBlock withErrors:(SalonErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:salonToken];
    
    [[RKObjectManager sharedManager] deleteObject:nil
                                             path:[NSString stringWithFormat:@"salon/staff/%@", professionalID]
                                       parameters:nil
                                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              
                                              NSLog(@"Success Removing Staff !!");
                                              
                                              if (mappingResult.array && mappingResult.array.count > 0) {
                                                  successBlock(mappingResult.array);
                                              } else {
                                                  successBlock(nil);
                                              }

                                          } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                              
                                              if (operation.HTTPRequestOperation.responseData) {
                                                  
                                                  // exctract error message
                                                  NSDictionary *myDic = [NSJSONSerialization
                                                                         JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                         options:NSJSONReadingMutableLeaves
                                                                         error:nil];
                                                  
                                                  NSString *errorMessage = [myDic valueForKey:@"message"];
                                                  NSNumber *errorCode = [myDic valueForKey:@"statusCode"];
                                                  
                                                  NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                                  errorBlock(error, errorMessage, errorCode.integerValue);
                                                  
                                              } else {
                                                  
                                                  errorBlock(error, @"You are not connected to the internet.", 0);
                                              }
                                          }];
}

@end
