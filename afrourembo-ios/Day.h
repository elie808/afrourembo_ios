//
//  Day.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject

//Use these properties for UI
//@property NSString *dayName;
@property NSNumber *day;
@property (assign, nonatomic) BOOL daySelected;

@property NSString *serviceStartDate;
@property NSString *serviceEndDate;

@property (assign, nonatomic) BOOL lunchBreakSelected;

@property NSString *lunchStartDate;
@property NSString *lunchEndDate;

//Use these properties for server operations

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

+ (Day *)defaultModelForDay:(NSNumber *)day;
//+ (Day *)defaultModelForDay:(NSString *)dayName;
+ (NSString *)dayStringFromNumber:(NSNumber *)dayNumber;
- (void)resetModel;

+ (NSString *)dayInitialsStringFromNumber:(NSNumber *)dayNumber;
+ (NSString *)fromTimeString:(Day *)day;
+ (NSString *)toTimeString:(Day *)day;

@end
