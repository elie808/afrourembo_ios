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

//+ (Day *)defaultModelForDay:(NSString *)dayName {
//    
//    Day *model = [Day new];
//    
//    model.dayName = dayName;
//    
//    model.daySelected = NO;
//    model.serviceStartDate  = kDefaultStartHour;
//    model.serviceEndDate    = kDefaultEndHour;
//    model.lunchBreakSelected = NO;
//    model.lunchStartDate    = kDefaultStartHour;
//    model.lunchEndDate      = kDefaultEndHour;
//    
//    return model;
//}

+ (Day *)defaultModelForDay:(NSNumber *)day {
    
    Day *model = [Day new];
    
    model.day = day;
    
    model.daySelected = NO;
    model.serviceStartDate  = kDefaultStartHour;
    model.serviceEndDate    = kDefaultEndHour;
    model.lunchBreakSelected = NO;
    model.lunchStartDate    = kDefaultStartHour;
    model.lunchEndDate      = kDefaultEndHour;
    
    return model;
}

- (void)resetModel {
    
    self.daySelected = NO;
    self.serviceStartDate   = kDefaultStartHour;
    self.serviceEndDate     = kDefaultEndHour;
    self.lunchBreakSelected = NO;
    self.lunchStartDate = kDefaultStartHour;
    self.lunchEndDate   = kDefaultEndHour;
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
