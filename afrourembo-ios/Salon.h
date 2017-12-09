//
//  Salon.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Pictures.h"
#import "Professional.h"
#import "Review.h"
#import "Service.h"

@interface SalonInfo : NSObject

@property NSString *name;
@property NSNumber *longitude;
@property NSNumber *latitude;
@property NSString *address;

@end

@interface SalonFacebook : NSObject
@property NSString *fbToken; //token returned by Facebook upon signup. Use to register user on our server
@end

@interface Salon : NSObject

@property NSString *salonID;
@property NSString *token;

@property NSString *fName;
@property NSString *lName;
@property NSString *email;
@property NSString *profilePicture;
@property NSString *name;
@property NSString *address;
@property NSString *phone;
@property NSString *password;

@property CGFloat longitude;
@property CGFloat latitude;

@property NSArray<Pictures*> *portfolio;

@property (assign, nonatomic) BOOL isCentralizedModel;

// unmapped fields
@property NSNumber *stars;
@property NSNumber *price;

// UI model fields
@property NSArray<Service*> *servicesArray;
@property NSArray<Review*> *reviewsArray;
@property Professional *selectedProfessional;

@end
