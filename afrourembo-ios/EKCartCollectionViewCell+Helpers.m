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

@end
