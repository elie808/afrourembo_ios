//
//  Customer+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Customer+API.h"

@implementation Customer (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Customer class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"token", @"fName", @"lName", @"phone"]];
    
    return mapping;
}

+ (RKObjectMapping *)map2 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Customer class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password"]];
    
    return mapping;
}

+ (RKObjectMapping *)map3 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Customer class]];
    [mapping addAttributeMappingsFromArray:@[@"fName", @"lName", @"phone"]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)userRegistrationRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Customer map2] inverseMapping]
                                    objectClass:[Customer class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)userRegistrationResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Customer map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kUserRegisterAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)putUserProfileResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Customer map1]
                                      method:RKRequestMethodPUT
                                      pathPattern:kUserProfileAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)userLoginResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Customer map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kUserLoginAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)signUpCustomer:(NSString *)email password:(NSString *)password withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock {

    Customer *customer = [Customer new];
    customer.email = email;
    customer.password = password;
    
    [[RKObjectManager sharedManager] postObject:customer
                                           path:kUserRegisterAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Customer *customerObj = [mappingResult.array firstObject];
                                            successBlock(customerObj);
                                            
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            
                                            // exctract error message
                                            NSDictionary *myDic = [NSJSONSerialization
                                                                   JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                   options:NSJSONReadingMutableLeaves
                                                                   error:nil];

                                            NSString *errorMessage = [myDic valueForKey:@"message"];

                                            NSNumber* statusCodeNumber = [myDic valueForKey:@"statusCode"];
                                            
                                            errorBlock(error, errorMessage, [statusCodeNumber integerValue]);
                                        }];
}

+ (void)loginCustomer:(NSString *)email password:(NSString *)password withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock {
    
    Customer *customer = [Customer new];
    customer.email = email;
    customer.password = password;
    
    [[RKObjectManager sharedManager] postObject:customer
                                           path:kUserLoginAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Customer *customerObj = [mappingResult.array firstObject];
                                            successBlock(customerObj);
                                            
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

+ (void)updateInterests:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone forUser:(NSString *)userToken withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerEditErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:firstName forKey:@"fName"];
    [params setValue:lastName forKey:@"lName"];
    [params setValue:phone forKey:@"phone"];
    
    [[RKObjectManager sharedManager] putObject:nil
                                          path:kUserProfileAPIPath
                                    parameters:params
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           
                                           NSLog(@"Success Updating Customer info!!");
                                           
                                           Customer *customerObj = [mappingResult.array firstObject];
                                           successBlock(customerObj);
                                       }
                                       failure:^(RKObjectRequestOperation *operation, NSError *error) {
                        
                                           if (operation.HTTPRequestOperation.responseData) {

                                               // exctract error message
                                               NSDictionary *myDic = [NSJSONSerialization
                                                                      JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                      options:NSJSONReadingMutableLeaves
                                                                      error:nil];
                                               
                                               NSString *errorMessage = [myDic valueForKey:@"message"];
                                               //                                           NSNumber *errorCode = [myDic valueForKey:@"statusCode"];
                                               
                                               NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                               
                                               errorBlock(error, errorMessage);
                                               
                                           } else {
                                               
                                               errorBlock(error, @"You are not connected to the internet.");
                                           }
                                       }];
}

+ (void)getResetCodeForPhonenumber:(NSString *)phoneNumber withBlock:(CustomerResetCodeSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"user/password/reset/%@", phoneNumber]
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

@end
