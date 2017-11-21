//
//  Professional+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Professional+API.h"

@implementation Professional (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Professional class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"token", @"fName", @"lName", @"phone", @"isMobile", @"about"]];
    
    [mapping addAttributeMappingsFromArray:@[@"ratingBasedOn", @"profilePicture"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"professionalID"}];

    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule"
                                                                            toKeyPath:@"schedule"
                                                                          withMapping:[Day map2]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"services"
                                                                            toKeyPath:@"services"
                                                                          withMapping:[Service map1]]];

    //FUCK THIS SHIT!!!!! :(
    RKObjectMapping *portfolioMapping = [RKObjectMapping mappingForClass:[Pictures class]];
    [portfolioMapping addAttributeMappingsFromArray:@[@"picture"]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{@"_id" : @"pictureID"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"portfolio"
                                                                            toKeyPath:@"portfolio"
                                                                          withMapping:portfolioMapping]];
    
    //FUCK THIS SHIT!!!!! :(
    RKObjectMapping *businessMapping = [RKObjectMapping mappingForClass:[BusinessInfo class]];
    [businessMapping addAttributeMappingsFromArray:@[@"address", @"name", @"longitude", @"latitude"]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"business"
                                                                            toKeyPath:@"business"
                                                                          withMapping:businessMapping]];
    
    return mapping;
}

+ (RKObjectMapping *)map2 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Professional class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"fName", @"lName", @"phone"]];

    return mapping;
}

+ (RKObjectMapping *)map3 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Professional class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password"]];
    
    return mapping;
}

+ (RKObjectMapping *)map4 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Professional class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"token", @"fName", @"lName", @"phone", @"isMobile"]];
    
    [mapping addAttributeMappingsFromArray:@[@"ratingBasedOn", @"profilePicture"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"professionalID"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schedule"
                                                                            toKeyPath:@"schedule"
                                                                          withMapping:[Day map2]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"services"
                                                                            toKeyPath:@"services"
                                                                          withMapping:[Service map1]]];
    
    //FUCK THIS SHIT!!!!! :(
    RKObjectMapping *portfolioMapping = [RKObjectMapping mappingForClass:[Pictures class]];
    [portfolioMapping addAttributeMappingsFromArray:@[@"picture"]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"portfolio"
                                                                            toKeyPath:@"portfolio"
                                                                          withMapping:portfolioMapping]];
    
    //FUCK THIS SHIT!!!!! :(
    RKObjectMapping *businessMapping = [RKObjectMapping mappingForClass:[BusinessInfo class]];
    [businessMapping addAttributeMappingsFromArray:@[@"address", @"name", @"location"]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"business"
                                                                            toKeyPath:@"business"
                                                                          withMapping:businessMapping]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)professionalRegistrationRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Professional map2] inverseMapping]
                                    objectClass:[Professional class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)professionalRegistrationResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalRegisterAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)professionalResetPassResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalPassResetAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)professionalClientsResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Customer map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kProfessionalClientsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)professionalProfileResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kUserProfessionalProfileAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)getProfessionalProfileResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kProfessionalProfileAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)putProfessionalProfileResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPUT
                                      pathPattern:kProfessionalProfileAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)signUpProfessional:(NSString *)email password:(NSString *)password  firstName:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone  withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    Professional *professional = [Professional new];
    
    professional.fName = fName;
    professional.lName = lName;
    professional.email = email;
    professional.password = password;
    professional.phone = phone;
    
    [[RKObjectManager sharedManager] postObject:professional
                                           path:kProfessionalRegisterAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Professional *profObj = [mappingResult.array firstObject];
                                            successBlock(profObj);
                                            
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

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    ResetPassword *resetObj = [ResetPassword new];
    resetObj.phoneNumber = phoneNumber;
    resetObj.userPassword = newPassword;
    resetObj.resetCode = confirmationCode;
    
    [[RKObjectManager sharedManager] postObject:resetObj
                                           path:kProfessionalPassResetAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Professional *profObj = [mappingResult.array firstObject];
                                            successBlock(profObj);
                                            
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

+ (void)getClients:(NSString *)token withBlock:(ProfessionalClientsSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kProfessionalClientsAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Clients !!");
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

+ (void)getProfile:(NSString *)profID withCustomerToken:(NSString *)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"user/professionals/%@/profile", profID]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success getting Professional Profile !!");
                                                  successBlock([mappingResult.array firstObject]);
                                                  
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

+ (void)getProfileForProfessional:(NSString *)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
 
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kProfessionalProfileAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success getting Professional Profile !!");
                                                  successBlock([mappingResult.array firstObject]);
                                                  
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

+ (void)udpateProfile:(NSString *)fName lastName:(NSString *)lName phoneNumber:(NSString *)phone about:(NSString *)aboutText withToken:(NSString *)userToken withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:fName forKey:@"fName"];
    [params setValue:lName forKey:@"lName"];
    [params setValue:phone forKey:@"phone"];
    [params setValue:aboutText forKey:@"about"];
    
    [[RKObjectManager sharedManager] putObject:nil
                                          path:kProfessionalProfileAPIPath
                                    parameters:params
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           
                                           NSLog(@"Success Updating Pro BIO!!");
                                           
                                           Professional *proObj = [mappingResult.array firstObject];
                                           successBlock(proObj);
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
