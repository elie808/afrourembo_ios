//
//  EKTodayCollectionViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKTodayCollectionViewCell.h"

static NSString * const kDone        = @"done";
static NSString * const kCancelled   = @"cancelled";
static NSString * const kScheduled   = @"scheduled";

static NSString * const kCheckImage     = @"icDone";
static NSString * const kUncheckImage   = @"icCanceled";

@implementation EKTodayCollectionViewCell

- (void)configureCellForAppointment:(Appointment *)appointment {
    
    self.cellClientNameLabel.text = appointment.clientName;
    self.cellServiceLabel.text = appointment.serviceDescription;
    self.cellTimeLabel.text = [NSString stringWithFormat:@"%@ %@ m", appointment.serviceTime, appointment.serviceDuration];

    if ([appointment.serviceStatus isEqualToString:kDone]) {
      
        [self setCellAsDone];
        
    } else if ([appointment.serviceStatus isEqualToString:kCancelled]) {
     
        [self setCellAsCancelled];
        
    } else {
        
        [self setCellAsScheduled];
    }
}

- (void)setCellAsDone {
    
    self.cellStatusImageView.image = [UIImage imageNamed:kCheckImage];
}

- (void)setCellAsCancelled {
    
    self.cellStatusImageView.image = [UIImage imageNamed:kUncheckImage];
}

- (void)setCellAsScheduled {
    
    self.cellStatusImageView.image = nil;
}

@end
