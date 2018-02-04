//
//  Favorite+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 2/5/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "Favorite+API.h"

@implementation Favorite (API)

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Favorite class]];
    [mapping addAttributeMappingsFromArray:@[@"address", @"businessName", @"rating", @"ratingBasedOn"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"userId"}];
    [mapping addAttributeMappingsFromDictionary:@{@"type" : @"userType"}];
    
    return mapping;
}

@end
