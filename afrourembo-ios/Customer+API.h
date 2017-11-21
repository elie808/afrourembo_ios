//
//  Customer+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Customer.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"
#import "ResetPassword.h"
#import "ClientBooking.h"
#import "Favorite.h"

typedef void (^CustomerSignUpSuccessBlock)(Customer *customerObj);
typedef void (^CustomerResetCodeSuccessBlock)(void);
typedef void (^CustomerFavoritesCodeSuccessBlock)(NSArray <Favorite*> *favoriteObj);
typedef void (^CustomerBookingsSuccessBlock)(NSArray <ClientBooking*> *customerObj);
typedef void (^CustomerSignUpErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);
typedef void (^CustomerEditErrorBlock)(NSError *error, NSString *errorMessage);

@interface Customer (API)

/// email, password, token, fName, lName, phone
+ (RKObjectMapping *)map1;

/// email, password
+ (RKObjectMapping *)map2;

/// fName, lName, phone
+ (RKObjectMapping *)map3;

/// Maps the returned reponse from the POST Sign Up call
+ (RKResponseDescriptor *)userRegistrationResponseDescriptor;

+ (RKResponseDescriptor *)putUserProfileResponseDescriptor;

+ (RKResponseDescriptor *)userResetPassResponseDescriptor;

/// Maps the returned reponse from the POST Login call
+ (RKResponseDescriptor *)userLoginResponseDescriptor;

/// Maps the RESPONSE for the POST call of customer Facebook signup
+ (RKResponseDescriptor *)fbUserRegistrationResponseDescriptor;

+ (RKResponseDescriptor *)fbUserLoginResponseDescriptor;

/// bookingId, currentBookingId, actorBusinessName, actorId, currency, date, price, professionalType, service, serviceId, status, professionalBusinessName, reviewed
+ (RKResponseDescriptor *)userBookingsResponseDescriptor;

+ (RKResponseDescriptor *)userPostFavoritesResponseDescriptor;

/// address, businessName, rating, ratingBasedOn, userType, userId
+ (RKResponseDescriptor *)userGetFavoritesResponseDescriptor;

/// customer DELETE vendor from favorites. mapping: address, businessName, rating, ratingBasedOn, userType, userId
+ (RKResponseDescriptor *)userDeleteFavoritesResponseDescriptor;

/// Maps the REQUEST for the POST call
+ (RKRequestDescriptor *)userRegistrationRequestDescriptor;

+ (RKRequestDescriptor *)fbCustomerRequestDescriptor;

/// Maps the REQUEST for the POST call of user Favorites
+ (RKRequestDescriptor *)userFavoritesRequestDescriptor;

/**
 Info here
 
 @param email The user's email address
 @param successBlock Server will return the user's phone number
 @param errorBlock Server error logging
 */
+ (void)signUpCustomer:(NSString *)email password:(NSString *)password withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)signUpCustomerWithFacebook:(NSString *)fbToken withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)loginCustomer:(NSString *)email password:(NSString *)password withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)loginCustomerWithFacebook:(NSString *)fbToken withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)updateCustomerProfile:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString *)phone forUser:(NSString *)userToken withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerEditErrorBlock)errorBlock;

/**
 Send an SMS reset code when method returns succesfully, to be enterred for reseting password.
 
 @param phoneNumber The user's phone number
 @param successBlock Server will return an empty response
 @param errorBlock Server error logging
 */
+ (void)getResetCodeForPhonenumber:(NSString *)phoneNumber withBlock:(CustomerResetCodeSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)resetPassword:(NSString *)newPassword forPhoneNumber:(NSString *)phoneNumber andConfirmationCode:(NSString *)confirmationCode withBlock:(CustomerSignUpSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)getBookingsForUser:(NSString *)token withBlock:(CustomerBookingsSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)postFavorite:(NSString *)userID vendorType:(NSString *)userType withToken:(NSString *)token withBlock:(CustomerFavoritesCodeSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)getFavoritesForUser:(NSString *)token withBlock:(CustomerFavoritesCodeSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

+ (void)deleteFavorite:(NSString *)userID withToken:(NSString *)token withBlock:(CustomerFavoritesCodeSuccessBlock)successBlock withErrors:(CustomerSignUpErrorBlock)errorBlock;

@end
