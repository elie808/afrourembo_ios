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
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"token", @"fName", @"lName", @"phone"]];
    
    //TODO: add mapping for schedule and services
    
    return mapping;
}

+ (RKObjectMapping *)map2 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Professional class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password", @"fName", @"lName"]];

    return mapping;
}

+ (RKObjectMapping *)map3 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Professional class]];
    [mapping addAttributeMappingsFromArray:@[@"email", @"password"]];
    
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

#pragma mark - APIs

+ (void)signUpProfessional:(NSString *)email password:(NSString *)password  firstName:(NSString *)fName lastName:(NSString *)lName  withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    Professional *professional = [Professional new];
    
    professional.fName = fName;
    professional.lName = lName;
    professional.email = email;
    professional.password = password;
    
    [[RKObjectManager sharedManager] postObject:professional
                                           path:kProfessionalRegisterAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            Professional *profObj = [mappingResult.array firstObject];
                                            successBlock(profObj);
                                            
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

@end