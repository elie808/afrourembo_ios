//
//  Category+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Category+API.h"

@implementation Category (API)

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Category class]];
    [mapping addAttributeMappingsFromArray:@[@"name", @"gender"]]; //TODO: Add icon
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id":@"categoryId"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"services"
                                                                            toKeyPath:@"services"
                                                                          withMapping:[Service map1]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)categoryResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Category map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kCategoriesAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
    
}

+ (void)getCategoriesWithBlock:(CategoriesSuccessBlock)successBlock withErrors:(CategoriesErrorBlock)errorBlock {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:kCategoriesAPIPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Categories!!");
                                                  successBlock([mappingResult.array firstObject]);
                                                  
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  // exctract error message
                                                  NSDictionary *myDic = [NSJSONSerialization
                                                                         JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                         options:NSJSONReadingMutableLeaves
                                                                         error:nil];
                                                  
                                                  NSString *errorMessage = [myDic valueForKey:@"message"];
                                                  
                                                  NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
                                                  
                                                  NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                                  errorBlock(error, errorMessage, [statusCode integerValue]);
                                              }];
}

@end
