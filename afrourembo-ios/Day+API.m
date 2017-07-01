//
//  Day+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Day+API.h"

@implementation Day (API)

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Day class]];
    [mapping addAttributeMappingsFromArray:@[@"day", @"fromHours", @"fromMinutes", @"toHours", @"toMinutes", @"lbFromHours", @"lbFromMinutes", @"lbToHours", @"lbToMinutes"]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)availabilityRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Day map1] inverseMapping]
                                    objectClass:[Day class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)availabilityResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Day map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalAvailabilityAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - API

+ (void)postAvailabilityDays:(NSArray *)availableDays professionalToken:(NSString*)token withBlock:(AvailabilitySuccessBlock)successBlock withErrors:(AvailabilityErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:token];
    
    [[RKObjectManager sharedManager] postObject:availableDays
                                           path:kProfessionalAvailabilityAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            NSArray *availableDays =  mappingResult.array; //[mappingResult.array firstObject];
                                            successBlock(availableDays);
                                            
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            
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
