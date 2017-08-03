//
//  Review.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

//@property NSString *reviewTitle;
//@property NSNumber *reviewStars;
//@property NSString *reviewAuthor;
//@property NSString *reviewText;
//@property NSString *reviewDate; //TODO: Change to NSDate
//
////TODO: Replace with professional NSObject
//@property NSString *reviewProfessional; // reviewed professional
//@property NSString *reviewProfessionalImage; // reviewed professional profile image

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
