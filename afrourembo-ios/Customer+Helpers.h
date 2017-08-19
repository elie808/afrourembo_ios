//
//  Customer+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Customer.h"

@interface Customer (Helpers)

/// email, token
+ (Customer *)customerFromJSON:(NSString *)customerJSONString;

/// email, token
+ (Customer *)updateCustomer:(Customer *)existingCustomer from:(Customer *)newCustomer;

- (NSString *)convertToJSON;

@end
