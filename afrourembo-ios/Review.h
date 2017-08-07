//
//  Review.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property NSString *reviewerFirstName;
@property NSString *reviewerLastName;
@property NSString *reviewerProfilePicture;
@property NSString *serviceName;
@property NSString *review;
@property NSDate *date;
@property NSNumber *rating;
@property NSString *actorId;
@property NSString *actorType;

@end
