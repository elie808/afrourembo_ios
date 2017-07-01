//
//  Salon+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Salon.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

@interface Salon (API)

/// fName, lName, token, email, password, phone
+ (RKObjectMapping *)map1;

@end
