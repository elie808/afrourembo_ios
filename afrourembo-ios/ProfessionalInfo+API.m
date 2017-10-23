//
//  ProfessionalInfo+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfessionalInfo+API.h"

@implementation ProfessionalInfo (API)

+ (RKObjectMapping *)map1 {
 
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[ProfessionalInfo class]];
    [mapping addAttributeMappingsFromArray:@[@"name", @"longitude", @"latitude", @"address"]];
    
    return mapping;
}

+ (RKRequestDescriptor *)professionalInfoRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[ProfessionalInfo map1] inverseMapping]
                                    objectClass:[ProfessionalInfo class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

+ (RKResponseDescriptor *)professionalInfoResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalInfoAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (void)postProInfo:(NSString *)businessName address:(NSString *)address longitude:(NSNumber *)longitude lattitude:(NSNumber *)latitude andToken:(NSString*)token withBlock:(ProfessionalSignUpSuccessBlock)successBlock withErrors:(ProfessionalSignUpErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    ProfessionalInfo *profInfo = [ProfessionalInfo new];
    profInfo.name = businessName;
    profInfo.longitude = longitude;
    profInfo.latitude = latitude;
    profInfo.address = address;
    
    [[RKObjectManager sharedManager] postObject:profInfo
                                           path:kProfessionalInfoAPIPath
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
