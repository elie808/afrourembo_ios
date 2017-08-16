//
//  Booking.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

#import "Reservation.h"

@interface Booking : RLMObject

// This is a class used for the EKCartViewController UI
@property NSString *bookingTitle;   //Service Type
@property NSString *bookingCost;    //cost
@property NSString *bookingVendor;  //Salon
@property NSString *practionner;    // Beauty Professional
@property NSDate *bookingDate;    // day/month/year
@property NSString *bookingDescription; // Free text ("Note" in the design), restricted to 300 chars

@property NSString *bookingOwner;
@property NSString *bookingHash;    // used as a primary key for storing and managing bookings in RLM

@property Reservation *reservation; // This property will be used to send to the server and make the booking from the cart

@end
