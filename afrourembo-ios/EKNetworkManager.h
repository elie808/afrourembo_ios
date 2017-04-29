//
//  EKNetworkManager.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#import "EKNetworkingConstants.h"

@interface EKNetworkManager : NSObject

+ (void)configureRestKit;

/// Configure RESPONSE Descriptors for the default RKObjectManager
+ (void)configureResponseDescriptors:(RKObjectManager *)objectManager;

/// Configure REQUEST Descriptors for the default RKObjectManager
+ (void)configureRequestDescriptors:(RKObjectManager *)objectManager;

@end
