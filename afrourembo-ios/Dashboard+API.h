//
//  Dashboard+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/6/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Dashboard.h"

#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^DashboardSuccessBlock)(NSArray<Dashboard *> *dashboardItems);
typedef void (^DashboardErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Dashboard (API)

/// itemId, bookingId, currency, price, startDate, endDate, service, customerId, fName, lName, phone, email
+ (RKObjectMapping *)map1;

+ (RKResponseDescriptor *)getDashboardResponseDescriptor;

+ (RKResponseDescriptor *)getSalonDashboardResponseDescriptor;

/**
 Returns all the bookings of a vendor with customer info and dates on each
 
 @param successBlock Server will return an array of vendor bookings
 @param errorBlock Server error logging
 */
+ (void)getDashboardOfVendor:(NSString *)userToken withBlock:(DashboardSuccessBlock)successBlock withErrors:(DashboardErrorBlock)errorBlock;

/**
 Returns all the bookings of a salon with customer info and dates on each
 
 @param successBlock Server will return an array of vendor bookings
 @param errorBlock Server error logging
 */
+ (void)getDashboardOfSalon:(NSString *)userToken withBlock:(DashboardSuccessBlock)successBlock withErrors:(DashboardErrorBlock)errorBlock;

@end
