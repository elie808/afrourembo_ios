//
//  Professional.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day+API.h"
#import "Service+API.h"

@interface Business : NSObject
@property NSString *name;
@property NSString *address;
@property NSDictionary *location;
@end

@interface Pictures : NSObject
@property NSString *picture;
@end

@interface Professional : NSObject

@property NSString *professionalID;

@property NSString *fName;
@property NSString *lName;
@property NSString *email;
@property NSString *phoneNumber;
@property NSString *password;

@property (assign, nonatomic) BOOL isMobile;

@property NSString *token;

@property NSNumber *ratingBasedOn;
@property NSString *profilePicture;
@property NSArray<Pictures*> *portfolio;
@property Business *business;

@property NSArray<Day *> *schedule;
@property NSArray<Service *> *services;

@end
