//
//  NSDate+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DateFormat) {
    DateFormatLetterDayMonthYear,
    DateFormatDigitYearMonthDay,
    DateFormatDigitYearMonth,
    DateFormatDigitHourMinute
};

@interface NSDate (Helpers)

@property (assign, nonatomic) DateFormat dateFormat;

+ (NSDate *)todayAtTime:(NSNumber *)hour minutes:(NSNumber *)minute;

+ (NSDate *)todayDate;
+ (NSDate *)tomorrowDate;
+ (NSDate *)nextDay:(NSDate *)date;
+ (NSDate *)monthsAdvance:(NSDate *)today numberOfMonths:(int)months;
+ (NSDate *)addDays:(NSInteger)daysToAdd after:(NSDate *)startingDate;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(DateFormat)dateFormat;
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(DateFormat)dateFormat;

@end
