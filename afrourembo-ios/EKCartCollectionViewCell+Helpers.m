//
//  EKCartCollectionViewCell+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCartCollectionViewCell+Helpers.h"

@implementation EKCartCollectionViewCell (Helpers)

- (void)configureCellWithBooking:(Booking *)booking {
    
    self.bookingTitleLabel.text = booking.bookingTitle;
    self.bookingCostLabel.text = booking.bookingCost;
    self.bookingVendorLabel.text = booking.bookingVendor;
    self.practionnerLabel.text = booking.practionner;
    self.bookingDateLabel.text = [NSDate stringFromDate:booking.bookingDate withFormat:DateFormatLetterDayMonthYear];
    self.bookingTimeLabel.text = [NSDate stringFromDate:booking.bookingDate withFormat:DateFormatDigitHourMinute];
    self.bookingDescriptionLabel.text = booking.bookingDescription;
}

- (void)configureCellWithOrder:(ClientBooking *)order {
    
    self.bookingTitleLabel.text = order.service;
    self.bookingCostLabel.text = [NSString stringWithFormat:@"%@ %@", order.price, order.currency];
    self.bookingVendorLabel.text = order.professionalBusinessName;
    self.practionnerLabel.text = order.actorBusinessName;
    self.bookingDateLabel.text = [NSDate stringFromDate:order.date withFormat:DateFormatLetterDayMonthYear];
    self.bookingTimeLabel.text = [NSDate stringFromDate:order.date withFormat:DateFormatDigitHourMinute];
    self.bookingDescriptionLabel.text = order.note;
    
    if (order.reviewed) {
        [self.actionButton setTitle:@"Order reviewed" forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[UIColor colorWithRed:55./255. green:170./255. blue:0./255. alpha:1.0]
                                forState:UIControlStateNormal];
        self.actionButton.enabled = NO;
    } else {
        [self.actionButton setTitle:@"Leave review" forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0]
                                forState:UIControlStateNormal];
        self.actionButton.enabled = YES;
    }
}

@end
