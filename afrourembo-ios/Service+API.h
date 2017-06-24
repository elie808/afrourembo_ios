//
//  Service+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Service.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^ServicesPostSuccessBlock)(Service *servicenObj);
typedef void (^ServicesErrorBlock)(NSError *error, NSString *errorMessage, NSNumber *statusCode);

@interface Service (API)

// name, price, time, serviceId, categoryId
+ (RKObjectMapping *)map1;

// categoryId, serviceId, price, time
+ (RKObjectMapping *)map2;

+ (RKResponseDescriptor *)postServicesResponseDescriptor;
+ (RKRequestDescriptor *)postServicesRequestDescriptor;

+ (void)postServiceForVendor:(NSString *)vendorToken forCategory:(NSString *)catID service:(NSString *)serviceID price:(CGFloat)price time:(CGFloat)time withBlock:(ServicesPostSuccessBlock)successBlock withErrors:(ServicesErrorBlock)errorBlock;

@end
