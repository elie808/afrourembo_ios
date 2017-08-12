//
//  Booking+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Booking.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^VendorBookingsSuccessBlock)(NSArray *array);
typedef void (^VendorBookingsErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Booking (API)

///
+ (RKObjectMapping *)map1;

/// Maps the returned reponse from the GET vendor bookings call
+ (RKResponseDescriptor *)getBookingsForVendorResponseDescriptor;

/**
 Returns all the available Categories in an array. No authentication needed.
 
 @param successBlock Server will return the categories and their corresponding services
 @param errorBlock Server error logging
 */
+ (void)getBookingsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType withToken:(NSString *)userToken withBlock:(VendorBookingsSuccessBlock)successBlock withErrors:(VendorBookingsErrorBlock)errorBlock;

@end
