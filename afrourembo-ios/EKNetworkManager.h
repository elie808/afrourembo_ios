//
//  EKNetworkManager.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#import "Booking+API.h"
#import "Category+API.h"
#import "Customer+API.h"
#import "Dashboard+API.h"
#import "Day+API.h"
#import "Explore+API.h"
#import "Professional+API.h"
#import "ProfessionalLogin+API.h"
#import "ProfessionalInfo+API.h"
#import "ProfilePicture+API.h"
#import "Reservation+API.h"
#import "ResetPassword+API.h"
#import "Review+API.h"
#import "Salon+API.h"
#import "SalonLogin+API.h"
#import "Service+API.h"

#import "EKNetworkingConstants.h"

@interface EKNetworkManager : NSObject

+ (void)configureRestKit;

/// Configure RESPONSE Descriptors for the default RKObjectManager
+ (void)configureResponseDescriptors:(RKObjectManager *)objectManager;

/// Configure REQUEST Descriptors for the default RKObjectManager
+ (void)configureRequestDescriptors:(RKObjectManager *)objectManager;

@end
