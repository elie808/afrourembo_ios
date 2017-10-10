//
//  Booking.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Booking.h"

@implementation Booking

+ (NSString *)primaryKey {
    return @"bookingHash";
}

+ (NSString *)hashBooking:(Booking *)bookingObj {
    
    NSString *hash = [NSString stringWithFormat:@"%@%@%@%@",
                      bookingObj.bookingOwner,
                      bookingObj.reservation.serviceId,
                      bookingObj.reservation.actorId,
                      bookingObj.bookingDate];
    
    return hash;
}

+ (Reservation *)convertBookingObj:(Booking *)bookingObj {
    
    Reservation *reservationObj = [Reservation new];
    
    reservationObj.bookingId    = bookingObj.reservation.bookingId;
    reservationObj.actorId      = bookingObj.reservation.actorId;
    reservationObj.serviceId    = bookingObj.reservation.serviceId;
    
    reservationObj.type = bookingObj.reservation.type;
    reservationObj.note = bookingObj.reservation.note;
    
    //to make sure we avoid weird "not iso8601" date errors on some devices...
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSString *iso8601FromDate   = [dateFormatter stringFromDate:bookingObj.reservation.fromDateTime];
    NSString *iso8601ToDate     = [dateFormatter stringFromDate:bookingObj.reservation.toDateTime];
    
    reservationObj.fromDateTime = [dateFormatter dateFromString:iso8601FromDate];
    reservationObj.toDateTime   = [dateFormatter dateFromString:iso8601ToDate];
    
    return reservationObj;
}

@end
