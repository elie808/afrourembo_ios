//
//  Review+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Review.h"
#import "ClientBooking.h"
#import "EKNetworkingConstants.h"

#import <RestKit/RestKit.h>

typedef void (^ReviewFetchSuccessBlock)(NSArray <Review*> *reviewsArray);
typedef void (^ReviewPostSuccessBlock)(Review *reviews);
typedef void (^ReviewErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Review (API)

/// reviewerFirstName, reviewerLastName, reviewerProfilePicture, serviceName, review, date, rating, actorId, actorType
+ (RKObjectMapping *)map1;

+ (RKRequestDescriptor *)postReviewsRequestDescriptor;

+ (RKResponseDescriptor *)postReviewsResponseDescriptor;
+ (RKResponseDescriptor *)getReviewsResponseDescriptor;

/// Get reviews for a professional when customer is browsing the company (pro/salon) profile
+ (void)getReviewsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType withToken:(NSString *)userToken withBlock:(ReviewFetchSuccessBlock)successBlock withErrors:(ReviewErrorBlock)errorBlock;

/// Post a review for a professional after a customer has booked and paid
+ (void)postReviewForBooking:(NSString *)bookingID withService:(NSString *)currentBookingID rating:(NSNumber *)rating andReview:(NSString *)review forUser:(NSString *)userToken withBlock:(ReviewPostSuccessBlock)successBlock withErrors:(ReviewErrorBlock)errorBlock;

@end
