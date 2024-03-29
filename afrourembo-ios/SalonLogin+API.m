//
//  SalonLogin+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "SalonLogin+API.h"

@implementation SalonLogin (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Salon class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password"]];
    
    return mapping;
}

#pragma mark - Requests

// major hack around RestKit. We use the CustomerFacebook to avoid collisions with the Customer class
+ (RKRequestDescriptor *)salonFBRequestDescriptor {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[SalonFacebook class]];
    [mapping addAttributeMappingsFromArray:@[@"fbToken"]];
    
    RKRequestDescriptor *request = [RKRequestDescriptor requestDescriptorWithMapping:[mapping inverseMapping]
                                                                         objectClass:[SalonFacebook class]
                                                                         rootKeyPath:nil
                                                                              method:RKRequestMethodPOST];
    
    return request;
}


+ (RKRequestDescriptor *)salonLoginRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[SalonLogin map1] inverseMapping]
                                    objectClass:[SalonLogin class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Response

+ (RKResponseDescriptor *)salonLoginResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Salon map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kSalonLoginAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)salonResetPassResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[ResetPassword map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kSalonPassResetAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)salonFBRegistrationResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Salon map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kSalonFBRegisterAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)signUpSalonWithFacebook:(NSString *)fbToken withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock {
    
    SalonFacebook *salon = [SalonFacebook new];
    salon.fbToken = fbToken;
    
    [[RKObjectManager sharedManager] postObject:salon
                                           path:kSalonFBRegisterAPIPath
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

+ (void)loginSalon:(NSString *)email password:(NSString *)password withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock {
 
    SalonLogin *salon = [SalonLogin new];
    salon.email = email;
    salon.password = password;
    
    [[RKObjectManager sharedManager] postObject:salon
                                           path:kSalonLoginAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Salon *salonObj = [mappingResult.array firstObject];
                                            successBlock(salonObj);
                                            
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

+ (void)getResetCodeForPhonenumber:(NSString *)phoneNumber withBlock:(SalonResetCodeSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"salon/password/reset/%@", phoneNumber]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success getting confirmation SMS!!");
                                                  successBlock();
                                                  
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

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(SalonSignUpSuccessBlock)successBlock withErrors:(SalonSignUpErrorBlock)errorBlock {
    
    ResetPassword *resetObj = [ResetPassword new];
    resetObj.phoneNumber = phoneNumber;
    resetObj.userPassword = newPassword;
    resetObj.resetCode = confirmationCode;
    
    [[RKObjectManager sharedManager] postObject:resetObj
                                           path:kSalonPassResetAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Salon *salonObj = [mappingResult.array firstObject];
                                            successBlock(salonObj);
                                            
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
