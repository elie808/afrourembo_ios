//
//  ProfessionalLogin+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfessionalLogin+API.h"

@implementation ProfessionalLogin (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[ProfessionalLogin class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password"]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)professionalLoginRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[ProfessionalLogin map1] inverseMapping]
                                    objectClass:[ProfessionalLogin class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)professionalLoginResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalLoginAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)loginProfessional:(NSString *)email password:(NSString *)password withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    ProfessionalLogin *professional = [ProfessionalLogin new];
    professional.email = email;
    professional.password = password;
    
    [[RKObjectManager sharedManager] postObject:professional
                                           path:kProfessionalLoginAPIPath
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

@end
