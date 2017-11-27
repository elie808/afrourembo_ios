//
//  ClientBooking.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kBookingStatusComplete = @"complete";
//static NSString * const kBookingStatusIncomplete = @"incomplete";

@interface ClientBooking : NSObject

@property NSString *bookingId;
@property NSString *currentBookingId;
@property NSString *actorBusinessName;
@property NSString *actorId;
@property NSString *currency;
@property NSDate *date;
@property NSNumber *price;
@property NSString *professionalType;
@property NSString *service;
@property NSString *serviceId;
@property NSString *status;
@property NSString *professionalBusinessName;
@property BOOL reviewed;

@end
