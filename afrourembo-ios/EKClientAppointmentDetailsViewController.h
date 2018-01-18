//
//  EKClientAppointmentDetailsViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 1/18/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>

#import "Appointment.h"

@interface EKClientAppointmentDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *clientProfilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *noteLabel;

@property (strong, nonatomic) Appointment *passedAppointment;

@end


/*
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
 */
