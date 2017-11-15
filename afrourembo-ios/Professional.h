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
@property CGFloat longitude;
@property CGFloat latitude;
@end

@interface Pictures : NSObject
@property NSString *picture;
@property NSString *pictureID;

/// UI property
@property (assign, nonatomic) BOOL isSelected;

@end

@interface ProfessionalFacebook : NSObject
@property NSString *fbToken; //token returned by Facebook upon signup. Use to register user on our server
@end

@interface Professional : NSObject

@property NSString *professionalID;

@property NSString *fName;
@property NSString *lName;
@property NSString *email;
@property NSString *phone;
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
