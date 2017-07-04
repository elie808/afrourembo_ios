//
//  Service+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Service+API.h"

@implementation Service (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {

    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Service class]];
    [mapping addAttributeMappingsFromArray:@[@"name", @"price", @"time", @"categoryId", @"serviceId", @"currency"]]; //TODO: Add icon

//    [mapping addAttributeMappingsFromDictionary:@{@"_id":@"serviceId"}];

    [mapping addAttributeMappingsFromDictionary:@{@"category":@"categoryName"}];
    [mapping addAttributeMappingsFromDictionary:@{@"service":@"serviceName"}];

    return mapping;
}

+ (RKObjectMapping *)map2 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Service class]];
    [mapping addAttributeMappingsFromArray:@[@"categoryId", @"serviceId", @"price", @"time"]];
    
    return mapping;
}

#pragma mark - Requests

+ (RKRequestDescriptor *)postServicesRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[Service map2] inverseMapping]
                                    objectClass:[Service class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

#pragma mark - Responses

+ (RKResponseDescriptor *)postServicesResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Service map1] //TODO: Might have to create new mapping
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalServiceAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)postServiceForVendor:(NSString *)vendorToken forCategory:(NSString *)catID service:(NSString *)serviceID price:(CGFloat)price time:(CGFloat)time withBlock:(ServicesPostSuccessBlock)successBlock withErrors:(ServicesErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:vendorToken];
    
    Service *serviceObj = [Service new];
    serviceObj.categoryId = catID;
    serviceObj.serviceId = serviceID;
    serviceObj.price = price;
    serviceObj.time = time;
    
    [[RKObjectManager sharedManager] postObject:serviceObj
                                           path:kProfessionalServiceAPIPath
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            NSLog(@"!! SERVICE POSTED !!");
                                            
                                            Service *serviceReponseObj = [mappingResult.array firstObject];
                                            successBlock(serviceReponseObj);
                                            
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            
                                            // exctract error message
                                            NSDictionary *myDic = [NSJSONSerialization
                                                                   JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                                                   options:NSJSONReadingMutableLeaves
                                                                   error:nil];
                                            
                                            NSString *errorMessage = [myDic valueForKey:@"message"];
                                            
                                            NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
                                            
                                            NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
                                            errorBlock(error, errorMessage, statusCode);
                                        }];
}

@end
