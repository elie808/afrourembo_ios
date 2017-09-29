//
//  Summary.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/22/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

/// UI class to display dashboard analytics nicely
@interface Summary : NSObject

@property NSInteger totalSalesValue;
@property NSInteger totalBookingsValue;

@property NSInteger monthlySalesValue;
@property NSInteger monthlyBookingsValue;

@property NSInteger lastWeekSalesValue;
@property NSInteger lastWeekBookingsValue;

@property NSInteger nextWeekSalesValue;
@property NSInteger nextWeekBookingsValue;

@end
