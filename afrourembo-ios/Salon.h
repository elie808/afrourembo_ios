//
//  Salon.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Service.h"

@interface Salon : NSObject

@property NSString *mainImageName;
@property NSNumber *stars;
@property NSNumber *price;
@property NSNumber *photoCount;
@property NSString *userImageName;
@property NSString *userName;
@property NSString *address;

//TODO: Encapsulate into object ?
@property CGFloat longitude;
@property CGFloat latitude;

//TODO: CHANGE STRUCTURE. POSSIBLY HAVE A SEPARATE TIME OBJECT
@property NSArray *timesArray;

@property NSArray<Service*> *servicesArray;

@end
