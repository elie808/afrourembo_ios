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
@property NSString *customerId;
@property NSString *service;

@property NSNumber *price;
@property NSString *note;

@property NSDate *startDate;
@property NSDate *endDate;

@property NSString *fName;
@property NSString *lName;
@property NSString *phone;
@property NSString *email;
@property NSString *profilePicture;

@end
