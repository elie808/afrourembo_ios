//
//  Booking.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Booking : NSObject

@property NSString *bookingTitle;   //Service Type
@property NSString *bookingCost;    //cost
@property NSString *bookingVendor;  //Salon
@property NSString *practionner;    // Beauty Professional
@property NSString *bookingDate;    // day/month/year
@property NSString *bookingTime;    // Time of the day
@property NSString *bookingDescription; // Free text ("Note" in the design), restricted to 300 chars

@end
