//
//  ResetPassword+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ResetPassword.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

@interface ResetPassword (API)

/// phoneNumber, resetCode, newPassword
+ (RKObjectMapping *)map1;

/// Maps the REQUEST for the POST call for all Reset password calls
+ (RKRequestDescriptor *)resetPasswordRequestDescriptor;

@end
