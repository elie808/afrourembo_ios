//
//  Day.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Helpers.h"

@interface Day : NSObject

//Use these properties for UI
@property NSDate *dayDate;

/// day name and date as strings. Used to display inside day cell in collectionview on bookingVC
@property NSString *dayName;

/// day number 0-6, used to determine Mon-Sun and handle availability in UI
@property NSNumber *dayNumber;

/// to highlight selected day cell in collectionview
@property (assign, nonatomic) BOOL daySelected;

/// hold all time slots of the day. Use as data source for time slots collection view in bookingVC
@property NSArray *timeSlotsArray;

@property NSString *serviceStartDate;
@property NSString *serviceEndDate;

@property (assign, nonatomic) BOOL lunchBreakSelected;

@property NSString *lunchStartDate;
@property NSString *lunchEndDate;

// Use these properties for server operations

@property NSNumber *fromHours;
@property NSNumber *fromMinutes;
@property NSNumber *toHours;
@property NSNumber *toMinutes;
@property NSNumber *lbFromHours;
@property NSNumber *lbFromMinutes;
@property NSNumber *lbToHours;
@property NSNumber *lbToMinutes;

//TODO: Need to make unifrom response from server to avoid multiple mappings
@property NSNumber *lunchBreakFromHours;
@property NSNumber *lunchBreakFromMinutes;
@property NSNumber *lunchBreakToHours;
@property NSNumber *lunchBreakToMinutes;

/// Produce a UI viewmodel from the server response of a Day object
+ (Day *)viewModelFrom:(Day *)responseObj;

+ (Day *)defaultModelForDay:(NSNumber *)day;
- (void)resetModel;

/// Set model values for lunch break to default from 1:00 PM to 2:00 PM
- (void)defaultLunchBreakValues;

/// Set model values for lunch break to 0s
- (void)resetLunchBreakValues;

+ (NSString *)dayStringFromNumber:(NSNumber *)dayNumber;
+ (NSString *)dayInitialsStringFromNumber:(NSNumber *)dayNumber;
+ (NSNumber *)dayNumberFromDay:(NSDate *)aDay;

/// Return a HH:MM string from hours and minutes NSNumber parameters
+ (NSString *)formatTimeStringFromHour:(NSNumber *)hour andMinutes:(NSNumber *)minutes;

/// correct for the fact that iOS counts days 1-7 (starting Sunday), and we need 0-6 (starting Monday). So we map iOS dayNumber values to values that work on our platform. Needless to mention how much of an utter shit salad this is.
+ (NSInteger)convertiOSDayToOurGaySystem:(NSInteger)iOSDayNumber;

@end
