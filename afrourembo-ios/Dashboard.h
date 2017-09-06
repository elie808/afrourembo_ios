//
//  Dashboard.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/6/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dashboard : NSObject

@property NSString *itemId;     // maps _id field from server

@property NSString *bookingId;
@property NSString *currency;

@property NSInteger *price;

@property NSDate *startDate;
@property NSDate *endDate;

@property NSString *service;
@property NSString *customerId;
@property NSString *fName;
@property NSString *lName;
@property NSString *phone;
@property NSString *email;

@end
