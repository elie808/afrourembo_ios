//
//  Favorite+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 2/5/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "Favorite.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

@interface Favorite (API)

/// userId, userType, address, businessName, rating, ratingBasedOn;
+ (RKObjectMapping *)map1;

@end
