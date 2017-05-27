//
//  Appointment.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appointment : NSObject

@property NSDate *appointmentDate;      // day, month, year

@property NSString *clientName;         // client full name
@property NSString *serviceDescription; // service name/desciption
@property NSString *serviceTime;        // start time in HH:mm
@property NSNumber *serviceDuration;    // total service duration in minutes
@property NSString *serviceStatus;      // done, cancelled, scheduled

@end
