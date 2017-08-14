//
//  NSDate+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "NSDate+Helpers.h"

@implementation NSDate (Helpers)

@dynamic dateFormat;

+ (NSDate *)todayAtTime:(NSNumber *)hour minutes:(NSNumber *)minute {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                          fromDate:[[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]]];
    [comps setHour:[hour intValue]];
    [comps setMinute:[minute intValue]];
    [comps setSecond:[@0 intValue]];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)todayDate {
    return [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
}

+ (NSDate *)tomorrowDate {
    
    NSDate *now = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    int daysToAdd = 1;
    NSDate *tomorrowDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    return tomorrowDate;
}

+ (NSDate *)addDays:(NSInteger)daysToAdd after:(NSDate *)startingDate {
    
    NSDate *dayAfter = [startingDate dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    return dayAfter;
}

+ (NSDate *)nextDay:(NSDate *)date {
    
    int daysToAdd = 1;
    
    NSDate *dayAfter = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    return dayAfter;
}

+ (NSDate *)monthsAdvance:(NSDate *)today numberOfMonths:(int)months {
    
    int daysToAdd = 30 * months;
    
    NSDate *monthsAfter = [today dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    return monthsAfter;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(DateFormat)dateFormat {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    switch (dateFormat) {
            
        case DateFormatLetterDayMonthYear:
            dateFormatter.dateFormat = @"EEEE MMMM dd";
            break;
            
        case DateFormatDigitYearMonthDay:
            dateFormatter.dateFormat = @"YYYY-MM-dd";
            break;
            
        case DateFormatDigitHourMinute:
            dateFormatter.dateFormat = @"HH:mm";
            break;
            
        case DateFormatDigitYearMonthDayHourMinute:
            dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
            break;
            
        default:
            break;
    }
    
    return [[dateFormatter stringFromDate:date] capitalizedString];
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(DateFormat)dateFormat {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    switch (dateFormat) {
            
        case DateFormatLetterDayMonthYear:
            dateFormatter.dateFormat = @"EEEE MMMM dd";
            break;
            
        case DateFormatDigitYearMonthDay:
            dateFormatter.dateFormat = @"yyyy-MM-dd";//@"yyyy-MM-dd";
            break;
            
        case DateFormatDigitYearMonth:
            dateFormatter.dateFormat = @"yyyy-MM";
            break;
            
        case DateFormatDigitHourMinute:
            dateFormatter.dateFormat = @"HH:mm";
            break;
            
        case DateFormatDigitYearMonthDayHourMinute:
            dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
            break;
            
        default:
            break;
    }
    
    NSDate *date =  [dateFormatter dateFromString:dateString];
    
    return date;
}

@end
