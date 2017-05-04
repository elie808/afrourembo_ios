//
//  Day.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject

@property NSString *dayName;
@property (assign, nonatomic) BOOL daySelected;

@property NSString *serviceStartDate;
@property NSString *serviceEndDate;

@property (assign, nonatomic) BOOL lunchBreakSelected;

@property NSString *lunchStartDate;
@property NSString *lunchEndDate;

+ (Day *)defaultModelForDay:(NSString *)dayName;
- (void)resetModel;

@end


