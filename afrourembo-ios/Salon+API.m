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
    [mapping addAttributeMappingsFromArray:@[@"token", @"fName", @"lName", @"email", @"profilePicture", @"name", @"address"]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"_id" : @"salonID"}];
    
    RKObjectMapping *portfolioMapping = [RKObjectMapping mappingForClass:[Pictures class]];
    [portfolioMapping addAttributeMappingsFromArray:@[@"picture"]];
    [portfolioMapping addAttributeMappingsFromDictionary:@{@"_id" : @"pictureID"}];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"portfolio"
                                                                            toKeyPath:@"portfolio"
                                                                          withMapping:portfolioMapping]];
    
    return mapping;
}

@end
