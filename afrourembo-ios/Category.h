//
//  Category.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"

@interface Category : NSObject

@property NSString *categoryId;
@property NSString *name;
@property NSString *gender;
@property NSArray<Service*> *services;
//@property NSString *icon;

@end
