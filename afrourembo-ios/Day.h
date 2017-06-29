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

+ (Day *)defaultModelForDay:(NSNumber *)day;
//+ (Day *)defaultModelForDay:(NSString *)dayName;
+ (NSString *)dayStringFromNumber:(NSNumber *)dayNumber;
- (void)resetModel;

@end

/*
{
    availabilities   Details [
                              Any of:
                              {
                                  day number
                                  fromHours number
                                  fromMinutes number
                                  toHours number
                                  toMinutes number
                                  lbFromHours number
                                  lbFromMinutes number
                                  lbToHours number
                                  lbToMinutes number 
                              }
                              ]
}
*/

