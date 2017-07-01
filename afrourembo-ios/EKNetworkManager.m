//
//  EKNetworkManager.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKNetworkManager.h"

@implementation EKNetworkManager

+ (void)configureRestKit {
    
    //---- Restkit Logging
    //    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    //    RKLogConfigureByName("Restkit/Network", RKLogLevelDebug);
    
    //---- initialize AFNetworking HTTPClient
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    //---- initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    [[objectManager HTTPClient] setDefaultHeader:@"content-type" value:RKMIMETypeJSON];
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    
    [EKNetworkManager configureRequestDescriptors:objectManager];
    [EKNetworkManager configureResponseDescriptors:objectManager];
}

#pragma mark - Request

+ (void)configureRequestDescriptors:(RKObjectManager *)objectManager {
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Day availabilityRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Customer userRegistrationRequestDescriptor],
                                                    ]];
    
    [objectManager addRequestDescriptor:[SalonLogin salonLoginRequestDescriptor]];
    [objectManager addRequestDescriptor:[ProfessionalLogin professionalLoginRequestDescriptor]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Professional professionalRegistrationRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Service postServicesRequestDescriptor]
                                                    ]];
}

#pragma mark - Response

+ (void)configureResponseDescriptors:(RKObjectManager *)objectManager {
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Day availabilityResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptor:[Category categoryResponseDescriptor]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Customer userRegistrationResponseDescriptor],
                                                     [Customer userLoginResponseDescriptor],
                                                     [Customer putUserProfileResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptor:[ProfessionalLogin professionalLoginResponseDescriptor]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Professional professionalRegistrationResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptor:[SalonLogin salonLoginResponseDescriptor]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Service postServicesResponseDescriptor]
                                                     ]];
}

@end
