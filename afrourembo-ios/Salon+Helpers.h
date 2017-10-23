//
//  Salon+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Salon.h"

@interface Salon (Helpers)

/// salonID, token
+ (Salon *)salonFromJSON:(NSString *)salonJSONString;

/// salonID, token
+ (Salon *)updateSalon:(Salon *)existingSalon from:(Salon *)newSalon;

- (NSString *)convertToJSON;

@end
