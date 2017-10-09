//
//  ResetPassword+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ResetPassword+API.h"

@implementation ResetPassword (API)

#pragma mark - Mapping

+ (RKObjectMapping *)map1 {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[ResetPassword class]];
    [mapping addAttributeMappingsFromArray:@[@"phoneNumber", @"resetCode"]];

    [mapping addAttributeMappingsFromDictionary:@{@"newPassword" : @"userPassword"}];
    
    return mapping;
}

#pragma mark - Request

+ (RKRequestDescriptor *)resetPasswordRequestDescriptor {
    
    RKRequestDescriptor *request = [RKRequestDescriptor
                                    requestDescriptorWithMapping:[[ResetPassword map1] inverseMapping]
                                    objectClass:[ResetPassword class]
                                    rootKeyPath:nil
                                    method:RKRequestMethodPOST];
    return request;
}

@end
