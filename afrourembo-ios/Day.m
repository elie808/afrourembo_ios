//
//  Day.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Day.h"

static NSString * const kDefaultStartHour = @"9:00 AM";
static NSString * const kDefaultEndHour = @"5:00 PM";

@implementation Day

+ (Day *)defaultModelForDay:(NSNumber *)day {
    
    Day *model = [Day new];
    
    model.day = day;
    
    model.daySelected = NO;
    model.serviceStartDate  = kDefaultStartHour;
    model.serviceEndDate    = kDefaultEndHour;
    model.lunchBreakSelected = NO;
    model.lunchStartDate    = kDefaultStartHour;
    model.lunchEndDate      = kDefaultEndHour;
    
    model.fromHours     = @9;
    model.fromMinutes   = @0;
    model.toHours       = @17;
    model.toMinutes     = @0;
    model.lbFromHours   = @0;
    model.lbFromMinutes = @0;
    model.lbToHours     = @0;
    model.lbToMinutes   = @0;
    
    return model;
}

- (void)resetModel {
    
    self.daySelected = NO;
    self.serviceStartDate   = kDefaultStartHour;
    self.serviceEndDate     = kDefaultEndHour;
    self.lunchBreakSelected = NO;
    self.lunchStartDate = kDefaultStartHour;
    self.lunchEndDate   = kDefaultEndHour;
    
    self.fromHours     = @9;
    self.fromMinutes   = @0;
    self.toHours       = @17;
    self.toMinutes     = @0;
    self.lbFromHours   = @0;
    self.lbFromMinutes = @0;
    self.lbToHours     = @0;
    self.lbToMinutes   = @0;
}

+ (NSString *)dayStringFromNumber:(NSNumber *)dayNumber {
 
    if ([dayNumber isEqualToNumber:@0]) {
        return @"Monday";
    }
    
    if ([dayNumber isEqualToNumber:@1]) {
        return @"Tuesday";
    }
    
    if ([dayNumber isEqualToNumber:@2]) {
        return @"Wednesday";
    }
    
    if ([dayNumber isEqualToNumber:@3]) {
        return @"Thursday";
    }
    
    if ([dayNumber isEqualToNumber:@4]) {
        return @"Friday";
    }
    
    if ([dayNumber isEqualToNumber:@5]) {
        return @"Saturday";
    }
    
    if ([dayNumber isEqualToNumber:@6]) {
        return @"Sunday";
    }
    
    return @"";
}

@end
