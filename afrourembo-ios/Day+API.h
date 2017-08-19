//
//  Day+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Day.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^AvailabilitySuccessBlock)(NSArray *daysArray);
typedef void (^AvailabilityErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Day (API)

/// day, fromHours, fromMinutes, toHours, toMinutes, lbFromHours, lbFromMinutes, lbToHours, lbToMinutes
+ (RKObjectMapping *)map1;

/// Used for mapping schedules of professionals returned on user/explore
/// day, fromHours, fromMinutes, toHours, toMinutes, lunchBreakFromHours, lunchBreakFromMinutes, lunchBreakToHours, lunchBreakToMinutes
+ (RKObjectMapping *)map2;

+ (RKRequestDescriptor *)availabilityRequestDescriptor;

+ (RKResponseDescriptor *)availabilityResponseDescriptor;

/// Used for mapping response of vendor's availability, when queried by the user
+ (RKResponseDescriptor *)vendorAvailabilityResponseDescriptor;

+ (void)postAvailabilityDays:(NSArray *)availableDays professionalToken:(NSString*)token withBlock:(AvailabilitySuccessBlock)successBlock withErrors:(AvailabilityErrorBlock)errorBlock;

/**
 Returns all the available days of a vendor, when queried by a user (to populate a booking VC calendar)
 
 @param successBlock Server will return an array of available days
 @param errorBlock Server error logging
 */
+ (void)getAvailabilityOfVendor:(NSString *)vendorID ofType:(NSString *)vendorType withToken:(NSString *)userToken withBlock:(AvailabilitySuccessBlock)successBlock withErrors:(AvailabilityErrorBlock)errorBlock;

@end

