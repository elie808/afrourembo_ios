//
//  Service.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kService1 = @"NATURAL HAIR";
static NSString * const kService2 = @"BEST WEAVING & EXTENSIONS";
static NSString * const kService3 = @"TRENDING BARBERS";
static NSString * const kService4 = @"SPECIAL OCCASIONS PROS";

@interface Service : NSObject

@property NSString *serviceTitle;
@property NSString *serviceImage;

@end
