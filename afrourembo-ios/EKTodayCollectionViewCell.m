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

static CGFloat const kDoneAlpha   = 0.2;

@implementation EKTodayCollectionViewCell

- (void)configureCellForAppointment:(Appointment *)appointment {
    
    self.cellClientNameLabel.text = appointment.clientName;
    self.cellServiceLabel.text = appointment.serviceDescription;
    self.cellTimeLabel.text = [NSString stringWithFormat:@"%@ %ld m", appointment.serviceTime, (long)appointment.serviceDuration];

    if (appointment.serviceStatus == 0) {

        [self setCellAsDone];
        
    } else if (appointment.serviceStatus == 1) {
     
        [self setCellAsCancelled];
        
    } else {
        
        [self setCellAsScheduled];
    }
}

- (void)setCellAsDone {
    
    self.cellClientNameLabel.alpha = kDoneAlpha;
    self.cellServiceLabel.alpha = kDoneAlpha;
    self.cellTimeLabel.alpha = kDoneAlpha;
    
    self.backgroundColor = [UIColor colorWithRed:254./255. green:254./255. blue:254./255. alpha:1.0];
    
    self.cellStatusImageView.image = [UIImage imageNamed:kCheckImage];
}

- (void)setCellAsCancelled {
    
    self.cellClientNameLabel.alpha = 1.0;
    self.cellServiceLabel.alpha = 1.0;
    self.cellTimeLabel.alpha = 1.0;
    
    self.backgroundColor = [UIColor colorWithRed:255./255. green:86./255. blue:0./255. alpha:0.2];
    
    self.cellStatusImageView.image = [UIImage imageNamed:kUncheckImage];
}

- (void)setCellAsScheduled {
    
    self.cellClientNameLabel.alpha = 1.0;
    self.cellServiceLabel.alpha = 1.0;
    self.cellTimeLabel.alpha = 1.0;
    
    self.backgroundColor = [UIColor colorWithRed:255./255. green:255./255. blue:124./255. alpha:0.2];
    
    self.cellStatusImageView.image = nil;
}

@end
