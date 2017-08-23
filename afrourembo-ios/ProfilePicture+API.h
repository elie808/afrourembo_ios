//
//  ProfilePicture+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfilePicture.h"
#import "Customer.h"
#import "Customer+API.h"
#import "EKNetworkingConstants.h"
#import <RestKit/RestKit.h>

typedef void (^UserProfilePictureSuccessBlock)(Customer *customer);
typedef void (^UserProfilePictureErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface ProfilePicture (API)

+ (RKResponseDescriptor *)putUserProfilePictureResponseDescriptor;

+ (void)uploadCustomerProfilePicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(UserProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

@end
