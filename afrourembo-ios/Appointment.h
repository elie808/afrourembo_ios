//
//  Appointment.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, AppointmentState)
//    AppointementDone,
//    AppointementCancelled,
//    AppointementScheduled
//;

@interface Appointment : NSObject

@property NSDate *appointmentDate;      // day, month, year

@property NSString *clientName;         // client full name
@property NSString *serviceDescription; // service name/desciption
@property NSString *serviceTime;        // start time in HH:mm
@property NSInteger serviceDuration;    // total service duration in minutes
@property NSInteger serviceStatus;      // 0,1,2 - done, cancelled, scheduled

@end
