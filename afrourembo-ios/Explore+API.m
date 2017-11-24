//
//  Explore+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Explore+API.h"

@implementation Explore (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Explore class]];

    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"professionals"
                                                                            toKeyPath:@"professionals"
                                                                          withMapping:[Professional map1]]];
    //TODO: Add salon mapping
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"salons"
                                                                            toKeyPath:@"salons"
                                                                          withMapping:[Salon map1]]];

    return mapping;
}

#pragma mark - Requests

#pragma mark - Responses

+ (RKResponseDescriptor *)exploreProfessionalsResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kUserExploreProfessionalsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)exploreSalonsResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Salon map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kUserExploreSalonsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)getProfessionalsForCategory:(NSString *)category andService:(NSString *)service WithBlock:(ExploreProfessionalsSuccessBlock)successBlock withErrors:(ExploreErrorBlock)errorBlock {
    
    NSString *URL;

    if (service && service.length > 0) {
        
        URL = [NSString stringWithFormat:@"%@?category=%@&service=%@", kUserExploreProfessionalsAPIPath, category, service];
    } else {
        
        URL = [NSString stringWithFormat:@"%@?category=%@", kUserExploreProfessionalsAPIPath, category];
    }
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[URL cleanupURL]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Professionals Explore!!");
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

+ (void)getSalonsForCategory:(NSString *)category andService:(NSString *)service WithBlock:(ExploreSalonsSuccessBlock)successBlock withErrors:(ExploreErrorBlock)errorBlock {
    
    NSString *URL;
    
    if (service && service.length > 0) {
        URL = [NSString stringWithFormat:@"%@?category=%@&service=%@", kUserExploreSalonsAPIPath, category, service];
    } else {
        URL = [NSString stringWithFormat:@"%@?category=%@", kUserExploreSalonsAPIPath, category];
    }

    [[RKObjectManager sharedManager] getObjectsAtPath:[URL cleanupURL]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Salons Explore!!");
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

@end
