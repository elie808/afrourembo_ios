//
//  Today.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/28/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Today : NSObject

//TODO: change to NSDate
@property NSString *appointmentsHour; // starting hour, use to divide appoitments into groups
@property NSMutableArray *appointmentsArray; // all appointment objects booked within an hour of appointmentsHour

@end
