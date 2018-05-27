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

#pragma mark - Day manipulation

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

#pragma mark - Date Formatting

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(DateFormat)dateFormat {
    
    NSDateFormatter *dateFormatter = [NSDate dateFormatter:dateFormat];
    
    return [[dateFormatter stringFromDate:date] capitalizedString];
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(DateFormat)dateFormat {
    
    NSDateFormatter *dateFormatter = [NSDate dateFormatter:dateFormat];
    
    NSDate *date =  [dateFormatter dateFromString:dateString];
    
    return date;
}

+ (NSDate *)date:(NSDate *)date withFormat:(DateFormat)dateFormat {
    
    NSDateFormatter *dateFormatter = [NSDate dateFormatter:dateFormat];
    
    return [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
}

#pragma mark - Helpers

+ (NSDateFormatter *)dateFormatter:(DateFormat)dateFormat {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 
    switch (dateFormat) {
            
        case DateFormatLetterDayMonthYear: dateFormatter.dateFormat = @"EEEE MMMM dd"; break;
            
        case DateFormatLetterDayMonthYearAbbreviated: dateFormatter.dateFormat = @"EEE MMM d"; break;
            
        case DateFormatDigitYearMonthDay: dateFormatter.dateFormat = @"yyyy-MM-dd"; break;
            
        case DateFormatDigitYearMonth: dateFormatter.dateFormat = @"yyyy-MM"; break;

        case DateFormatDigitMonthYear: dateFormatter.dateFormat = @"MM-yyyy"; break;
            
        case DateFormatDigitMonth: dateFormatter.dateFormat = @"MM"; break;
            
        case DateFormatDigitYear: dateFormatter.dateFormat = @"yyyy"; break;
            
        case DateFormatDigitMonthDashYear: dateFormatter.dateFormat = @"MM/yy"; break;
            
        case DateFormatDigitHourMinute: dateFormatter.dateFormat = @"HH:mm"; break;
            
        case DateFormatDigitYearMonthDayHourMinute: dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm"; break;
            
        default: break;
    }
    
    return dateFormatter;
}

@end
