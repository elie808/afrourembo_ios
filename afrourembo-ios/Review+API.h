//
//  Review+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Review.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^ReviewFetchSuccessBlock)(NSArray <Review*> *reviewsArray);
typedef void (^ReviewErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Review (API)

/// reviewerFirstName, reviewerLastName, reviewerProfilePicture, serviceName, review, date, rating, actorId, actorType
+ (RKObjectMapping *)map1;

+ (RKResponseDescriptor *)getReviewsResponseDescriptor;

+ (void)getReviewsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType withToken:(NSString *)userToken withBlock:(ReviewFetchSuccessBlock)successBlock withErrors:(ReviewErrorBlock)errorBlock;

@end
