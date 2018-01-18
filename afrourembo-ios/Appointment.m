//
//  Appointment.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Appointment.h"
#import <DateTools/DateTools.h>

@implementation Appointment

+ (Appointment *)convertToAppointementObject:(Dashboard *)dashboardObject {
    
    Appointment *appt1 = [Appointment new];
    appt1.clientName = [NSString stringWithFormat:@"%@ %@", dashboardObject.fName, dashboardObject.lName];
    appt1.clientPhone = dashboardObject.phone;
    appt1.clientEmail = dashboardObject.email;
    appt1.clientProfilePicture = dashboardObject.profilePicture;
    
    appt1.serviceDescription = dashboardObject.service;
    appt1.servicePrice = [dashboardObject.price integerValue];
    appt1.serviceNote = dashboardObject.note;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh a";
    appt1.serviceTime = [dateFormatter stringFromDate:dashboardObject.startDate];
    
    appt1.serviceDuration = [dashboardObject.endDate minutesFrom:dashboardObject.startDate];
    appt1.serviceStatus = 2; //mark as scheduled

    return appt1;
}

@end
