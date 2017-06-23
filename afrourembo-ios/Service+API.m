//
//  Service+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Service+API.h"

@implementation Service (API)

+ (RKObjectMapping *)map1 {

    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Service class]];
    [mapping addAttributeMappingsFromArray:@[@"name"]]; //TODO: Add icon
    
    return mapping;
}

@end
