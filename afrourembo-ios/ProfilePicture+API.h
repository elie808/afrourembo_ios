//
//  ProfilePicture+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfilePicture.h"

#import "Customer.h"
#import "Professional.h"
#import "Salon.h"

#import "Customer+API.h"
#import "Professional+API.h"
#import "Salon+API.h"

#import "EKNetworkingConstants.h"
#import <RestKit/RestKit.h>

typedef void (^UserProfilePictureSuccessBlock)(Customer *customer);
typedef void (^ProfessionalProfilePictureSuccessBlock)(Professional *professional);
typedef void (^SalonProfilePictureSuccessBlock)(Salon *salon);
typedef void (^UserProfilePictureErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface ProfilePicture (API)

+ (RKResponseDescriptor *)postUserProfilePictureResponseDescriptor;
+ (RKResponseDescriptor *)postProfessionalProfilePictureResponseDescriptor;
+ (RKResponseDescriptor *)postProfessionalPortfolioPictureResponseDescriptor;
+ (RKResponseDescriptor *)deleteProfessionalPortfolioPictureResponseDescriptor;
+ (RKResponseDescriptor *)deleteSalonPortfolioPictureResponseDescriptor;
+ (RKResponseDescriptor *)postSalonPortfolioPictureResponseDescriptor;

+ (void)uploadCustomerProfilePicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(UserProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

+ (void)uploadProfessionalProfilePicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(ProfessionalProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

+ (void)uploadProfessionalPortfolioPicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(ProfessionalProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

+ (void)deleteProfessionalPortfolioPictureWithID:(NSString *)picID withToken:(NSString *)userToken withBlock:(ProfessionalProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

+ (void)uploadSalonPortfolioPicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(SalonProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

+ (void)deleteSalonPortfolioPictureWithID:(NSString *)picID withToken:(NSString *)userToken withBlock:(SalonProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock;

@end
