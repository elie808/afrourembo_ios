//
//  Booking+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Booking+API.h"

@implementation Booking (API)

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Booking class]];
    [mapping addAttributeMappingsFromArray:@[@"bookingTitle"]];
    
//    [mapping addAttributeMappingsFromDictionary:@{@"_id":@"categoryId"}];
    
//    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"services"
//                                                                            toKeyPath:@"services"
//                                                                          withMapping:[Service map1]]];
    
    return mapping;
}

+ (RKResponseDescriptor *)getBookingsForVendorResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Booking map1]
                                      method:RKRequestMethodGET
                                      pathPattern:kProfessionalBookingsAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
    
}

+ (void)getBookingsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType withToken:(NSString *)userToken withBlock:(VendorBookingsSuccessBlock)successBlock withErrors:(VendorBookingsErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];

    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"user/vendor/%@/bookings?type=%@", vendorID, vendorType]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  
                                                  NSLog(@"Success Fetching Vendor Bookings!!");
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
