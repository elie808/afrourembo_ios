//
//  Appointment.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dashboard.h"

//typedef NS_ENUM(NSInteger, AppointmentState)
//    AppointementDone,
//    AppointementCancelled,
//    AppointementScheduled
//;

/// UI model class, we convert Dashboard objects to Appointement objs via helper method
@interface Appointment : NSObject

@property NSDate *appointmentDate;      // day, month, year

@property NSString *clientName;         // client full name
@property NSString *serviceDescription; // service name/desciption
@property NSString *serviceTime;        // start time in HH:mm
@property NSInteger serviceDuration;    // total service duration in minutes
@property NSInteger serviceStatus;      // 0,1,2 - done, cancelled, scheduled

@property NSInteger servicePrice;
@property NSString *serviceNote;

@property NSString *clientPhone;
@property NSString *clientEmail;
@property NSString *clientProfilePicture;

/// pure convenience method, to keep using Appointment objects, since this view's UI was built on them initially...
+ (Appointment *)convertToAppointementObject:(Dashboard *)dashboardObject;

@end
