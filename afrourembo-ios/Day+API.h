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

//typedef void (^CustomerSignUpSuccessBlock)(Customer *customerObj);
//typedef void (^CustomerSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Day (API)

///
+ (RKObjectMapping *)map1;

@end

