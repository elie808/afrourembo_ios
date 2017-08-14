//
//  Reservation.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reservation : NSObject

@property NSString *actorId;
@property NSString *serviceId;
@property NSDate *fromDateTime;
@property NSDate *toDateTime;
@property NSString *type;
@property NSString *note;

@property NSString *bookingId;

@end
