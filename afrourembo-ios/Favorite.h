//
//  Favorite.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Favorite : NSObject

/// used to map the _id received from server, not to be confused with userId. MOTHERFUCK THIS RETARDED DESIGN
@property NSString *serverID;

@property NSString *userId;
@property NSString *userType;

@property NSString *address;
@property NSString *businessName;
@property NSNumber *rating;
@property NSNumber *ratingBasedOn;

@end
