//
//  EKCartCollectionViewCell+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCartCollectionViewCell.h"
#import "Booking.h"
#import "ClientBooking.h"
#import "NSDate+Helpers.h"
#import <DateTools/DateTools.h>

@interface EKCartCollectionViewCell (Helpers)

- (void)configureCellWithBooking:(Booking *)booking;

/// Called to configure cells on orders/payments view
- (void)configureCellWithOrder:(ClientBooking *)order;

@end
