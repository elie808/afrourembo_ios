//
//  Reservation+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/12/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Reservation.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^UserReservationSuccessBlock)(NSArray <Reservation*> *reservationsArray);
typedef void (^MakeUserReservationSuccessBlock)(Reservation *reservation);

typedef void (^UserReservationErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Reservation (API)

/// actorId, serviceId, fromDateTime, toDateTime, type, note,
+ (RKObjectMapping *)map1;

/// bookingId
+ (RKObjectMapping *)map2;

+ (RKRequestDescriptor *)reservationsRequestDescriptor;

+ (RKResponseDescriptor *)getReservationsResponseDescriptor;
+ (RKResponseDescriptor *)postReservationsResponseDescriptor;

+ (void)getUserReservations:(NSString *)userToken withBlock:(UserReservationSuccessBlock)successBlock withErrors:(UserReservationErrorBlock)errorBlock;

//+ (void)postUserReservationForVendor:(NSString *)actorID vendorType:(NSString *)vendorType vendorService:(NSString*)serviceID fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate withNote:(NSString *)note userToken:(NSString *)token withBlock:(MakeUserReservationSuccessBlock)successBlock withErrors:(UserReservationErrorBlock)errorBlock;

+ (void)postUserReservations:(NSArray <Reservation*> *)reservationsArray forUser:(NSString *)token withBlock:(MakeUserReservationSuccessBlock)successBlock withErrors:(UserReservationErrorBlock)errorBlock;

@end
