//
//  Bank+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/16/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "Bank+API.h"

@implementation Bank (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
 
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Bank class]];
    
    [mapping addAttributeMappingsFromArray:@[@"name"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id":@"bankID"}];
        
    return mapping;
}

+ (RKObjectMapping *)map2 {

    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Bank class]];
    [mapping addAttributeMappingsFromArray:@[@"bankId", @"fName", @"lName", @"accountNumber"]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)professionalBankInfoRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Bank map2] inverseMapping]
                                    objectClass:[Bank class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)getBanksResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Bank map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kBankListAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)professionalBankPostResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalBankAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)getBanksListWithBlock:(BanksListSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock {

    [[RKObjectManager sharedManager] getObjectsAtPath:@"banks"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Banks List!!");
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

+ (void)postPaymentInfoForProfessional:(NSString*)token bank:(NSString *)bankId firstName:(NSString *)fName lastName:(NSString *)lName acountNumber:(NSString *)account  withBlock:(ProfessionalBankPostSuccessBlock)successBlock withErrors:(BanksListErrorBlock)errorBlock {
    
    Bank *bank = [Bank new];
    
    bank.bankId = bankId;
    bank.fName = fName;
    bank.lName = lName;
    bank.accountNumber = account;
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    [[RKObjectManager sharedManager] postObject:bank
                                           path:kProfessionalBankAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            //TODO: THIS IS NOT GETTING MAPPED PROPERLY !! FIX IT !!
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


@end
