//
//  Professional.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bank.h"
#import "BusinessInfo.h"
#import "Pictures.h"
#import "Day+API.h"
#import "Service+API.h"

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
@property NSString *about;

@property (assign, nonatomic) BOOL isMobile;
@property (assign, nonatomic) BOOL paymentInfoComplete;

@property NSString *token;

@property NSNumber *rating;
@property NSNumber *ratingBasedOn;
@property NSString *profilePicture;

@property BusinessInfo *business;

@property NSArray<Day *> *schedule;
@property NSArray<Pictures*> *portfolio;
@property NSArray<Service *> *services;
@property NSArray *partOf; // list of salons the professional is part of

@property Bank *paymentInfo;

@end
