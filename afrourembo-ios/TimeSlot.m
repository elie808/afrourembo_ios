//
//  TimeSlot.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "TimeSlot.h"

@implementation TimeSlot

- (instancetype)initWithDate:(NSDate *)date andAvailability:(BOOL)isTimeSlotAvailable {
    
    self = [super init];
    
    if (self) {

        self.date = date;
        self.isAvailable = isTimeSlotAvailable;
        self.isSelected = NO;
        self.hourString = [NSDate stringFromDate:self.date withFormat:DateFormatDigitHourMinute];
    }
    
    return self;
}

@end
