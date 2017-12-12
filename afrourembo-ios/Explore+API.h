//
//  Explore+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Explore.h"
#import <RestKit/RestKit.h>
#import "Professional+API.h"
#import "Salon+API.h"
#import "NSString+Helpers.h"
#import "EKNetworkingConstants.h"

typedef void (^ExploreProfessionalsSuccessBlock)(NSArray <Professional *> *proArray);
typedef void (^ExploreSalonsSuccessBlock)(NSArray <Salon *> *salonArray);
typedef void (^ExploreErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Explore (API)

+ (RKResponseDescriptor *)exploreProfessionalsResponseDescriptor;
+ (RKResponseDescriptor *)exploreSalonsResponseDescriptor;

+ (void)getProfessionalsForCategory:(NSString *)category andQuery:(NSString *)query WithBlock:(ExploreProfessionalsSuccessBlock)successBlock withErrors:(ExploreErrorBlock)errorBlock;

+ (void)getSalonsForCategory:(NSString *)category andQuery:(NSString *)query WithBlock:(ExploreSalonsSuccessBlock)successBlock withErrors:(ExploreErrorBlock)errorBlock;

@end
