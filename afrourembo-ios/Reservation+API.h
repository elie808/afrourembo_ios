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
typedef void (^UserReservationErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Reservation (API)

+ (RKObjectMapping *)map1;

+ (RKResponseDescriptor *)reservationsResponseDescriptor;

+ (void)getUserReservations:(NSString *)userToken withBlock:(UserReservationSuccessBlock)successBlock withErrors:(UserReservationErrorBlock)errorBlock;

@end
