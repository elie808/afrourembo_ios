//
//  TimeSlot.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Helpers.h"

@interface TimeSlot : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *hourString;
@property (assign, nonatomic) BOOL isAvailable;
@property (assign, nonatomic) BOOL isSelected;

- (instancetype)initWithDate:(NSDate *)date andAvailability:(BOOL)isTimeSlotAvailable;

@end
