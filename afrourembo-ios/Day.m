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

static NSString * const kDefaultLunchStartHour = @"1:00 PM";
static NSString * const kDefaultLunchEndHour = @"2:00 PM";

@implementation Day

+ (Day *)defaultModelForDay:(NSNumber *)day {
    
    Day *model = [Day new];
    
//    model.day = day;
    model.dayNumber = day;
    
    model.daySelected = NO;
    model.serviceStartDate  = kDefaultStartHour;
    model.serviceEndDate    = kDefaultEndHour;
    model.lunchBreakSelected = NO;
    model.lunchStartDate    = kDefaultLunchStartHour;
    model.lunchEndDate      = kDefaultLunchEndHour;
    
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
    self.lunchStartDate = kDefaultLunchStartHour;
    self.lunchEndDate   = kDefaultLunchEndHour;
    
    self.fromHours     = @9;
    self.fromMinutes   = @0;
    self.toHours       = @17;
    self.toMinutes     = @0;
    self.lbFromHours   = @0;
    self.lbFromMinutes = @0;
    self.lbToHours     = @0;
    self.lbToMinutes   = @0;
}

- (void)defaultLunchBreakValues {
    
    self.lbFromHours   = @13;
    self.lbFromMinutes = @0;
    self.lbToHours     = @14;
    self.lbToMinutes   = @0;
}

- (void)resetLunchBreakValues {
    
    self.lbFromHours   = @0;
    self.lbFromMinutes = @0;
    self.lbToHours     = @0;
    self.lbToMinutes   = @0;
}

+ (NSNumber *)dayNumberFromDay:(NSDate *)aDay {

    NSDateFormatter *dateFormatter = [NSDate dateFormatter:DateFormatLetterDayMonthYear];
    NSDate *date =  [dateFormatter dateFromString:[NSDate stringFromDate:aDay withFormat:DateFormatLetterDayMonthYear]];

    NSCalendar *cal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [cal components:NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    
    NSInteger dayNumber = [components weekday]; // get iOS' weekDay value. We correct for in what follows
    
    return [NSNumber numberWithInteger:[Day convertiOSDayToOurGaySystem:dayNumber]];
}

+ (NSInteger)convertiOSDayToOurGaySystem:(NSInteger)iOSDayNumber {
    
    switch (iOSDayNumber) {
            
        case 2: return 0; break; //Monday
            
        case 3: return 1; break; //Tuesday
            
        case 4: return 2; break; //Wednesday
            
        case 5: return 3; break; //Thursday
            
        case 6: return 4; break; //Friday
            
        case 7: return 5; break; //Saturday
            
        case 1: return 6; break; //Sunday
            
        default: return 10; break; //return whatever. This will probably blow up another method somewhere. Debug accordingly
    }
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

+ (NSString *)dayInitialsStringFromNumber:(NSNumber *)dayNumber {
    
    if ([dayNumber isEqualToNumber:@0]) {
        return @"M";
    }
    
    if ([dayNumber isEqualToNumber:@1]) {
        return @"T";
    }
    
    if ([dayNumber isEqualToNumber:@2]) {
        return @"W";
    }
    
    if ([dayNumber isEqualToNumber:@3]) {
        return @"TH";
    }
    
    if ([dayNumber isEqualToNumber:@4]) {
        return @"F";
    }
    
    if ([dayNumber isEqualToNumber:@5]) {
        return @"SAT";
    }
    
    if ([dayNumber isEqualToNumber:@6]) {
        return @"SUN";
    }
    
    return @"";
}

+ (NSString *)fromTimeString:(Day *)day {
    
    NSString *hours = [NSString stringWithFormat:@"%02ld", (long)[day.fromHours integerValue]];
    NSString *minutes = [NSString stringWithFormat:@"%02ld", (long)[day.fromMinutes integerValue]];
    
    return [NSString stringWithFormat:@"%@:%@", hours, minutes];
}

+ (NSString *)toTimeString:(Day *)day {
    
    NSString *hours = [NSString stringWithFormat:@"%02ld", (long)[day.toHours integerValue]];
    NSString *minutes = [NSString stringWithFormat:@"%02ld", (long)[day.toMinutes integerValue]];
    
    return [NSString stringWithFormat:@"%@:%@", hours, minutes];
}

@end
