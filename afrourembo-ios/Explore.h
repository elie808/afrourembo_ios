//
//  Explore.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Professional.h"
#import "Salon.h"

@interface Explore : NSObject

@property NSArray<Professional*> *professionals;
@property NSArray<Salon*> *salons;

@end
