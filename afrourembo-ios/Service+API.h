//
//  Service+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Service.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

@interface Service (API)

// categoryId, categoryName, categoryGender, categoryServices, categoryIcon
+ (RKObjectMapping *)map1;

@end
