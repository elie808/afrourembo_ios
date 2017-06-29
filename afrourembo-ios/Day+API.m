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
    [mapping addAttributeMappingsFromArray:@[]];
    
    return mapping;
}

@end
