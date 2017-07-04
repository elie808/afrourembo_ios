//
//  Explore+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Explore.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^ExploreSuccessBlock)(Explore *exploreObj);
typedef void (^ExploreErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Explore (API)

/// professionals, salons
+ (RKObjectMapping *)map1;

+ (RKResponseDescriptor *)exploreResponseDescriptor;

+ (void)getExploreLocationsForUser:(NSString *)userToken WithBlock:(ExploreSuccessBlock)successBlock withErrors:(ExploreErrorBlock)errorBlock;

@end
