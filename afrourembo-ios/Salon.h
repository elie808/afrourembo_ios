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
#import "Review.h"
#import "Service.h"

@interface Salon : NSObject

@property NSString *salonID;
@property NSString *token;

@property NSString *fName;
@property NSString *lName;
@property NSString *email;
@property NSString *profilePicture;
@property NSString *name;
@property NSString *address;

@property NSArray<Pictures*> *portfolio;

// unmapped fields
@property NSNumber *stars;
@property NSNumber *price;

//TODO: Encapsulate into object ?
@property CGFloat longitude;
@property CGFloat latitude;

//TODO: CHANGE STRUCTURE. POSSIBLY HAVE A SEPARATE TIME OBJECT
@property NSArray *timesArray;

@property (assign, nonatomic) BOOL isCentralizedModel;

@property NSArray<Service*> *servicesArray;
@property NSArray<Review*> *reviewsArray;

@end
