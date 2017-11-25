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

#pragma mark - Responses

+ (RKResponseDescriptor *)getStaffResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kSalonStaffAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

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

@end
