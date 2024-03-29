//
//  Service.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// stubs
static NSString * const kService1 = @"NATURAL HAIR";
static NSString * const kService2 = @"BEST WEAVING & EXTENSIONS";
static NSString * const kService3 = @"TRENDING BARBERS";
static NSString * const kService4 = @"SPECIAL OCCASIONS PROS";

@interface Service : NSObject

@property NSString *serviceId;  // used to map the _id property
@property NSString *categoryId; // category to which the service belongs.

@property NSString *serverServiceId; //temporary property to avoid blow ups... We'll need to make serviceID uniform later

@property NSString *categoryName;
@property NSString *serviceName;
@property NSString *currency;

@property NSString *name;
@property NSString *icon;

@property NSInteger price; //price
@property NSInteger time; //in minutes

@end
