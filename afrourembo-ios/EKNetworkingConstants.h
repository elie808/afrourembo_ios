//
//  EKNetworkingConstants.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#ifndef EKNetworkingConstants_h
#define EKNetworkingConstants_h

#pragma mark - URLs

static NSString * const kBaseURL = @"http://35.158.118.170/api/v1/";

#pragma mark - Routes

static NSString * const kCategoriesAPIPath   = @"categories";

static NSString * const kUserRegisterAPIPath = @"user/register";
static NSString * const kUserFBRegisterAPIPath = @"user/facebook/register";
static NSString * const kUserFBLoginAPIPath    = @"user/facebook/login";
static NSString * const kUserLoginAPIPath    = @"user/login";
static NSString * const kUserProfileAPIPath  = @"user/profile";
static NSString * const kUserExploreAPIPath  = @"user/explore";
static NSString * const kUserReviewsAPIPath  = @"user/reviews/:id";
static NSString * const kVendorAvailabilityAPIPath = @"user/professional/:userId/availability";
static NSString * const kUserProfilePictureAPIPath = @"user/profile/picture";
static NSString * const kUserReservationsAPIPath     = @"user/reservations";
static NSString * const kProfessionalBookingsAPIPath = @"user/vendor/:userId/bookings";

static NSString * const kProfessionalAvailabilityAPIPath = @"professional/availability";
static NSString * const kProfessionalDashboardAPIPath    = @"professional/dashboard";
static NSString * const kProfessionalLoginAPIPath        = @"professional/login";
static NSString * const kProfessionalPictureAPIPath  = @"professional/profile/picture";
static NSString * const kProfessionalRegisterAPIPath = @"professional/register";
static NSString * const kProfessionalServiceAPIPath  = @"professional/services";

static NSString * const kSalonLoginAPIPath    = @"salon/login";

#pragma mark - Status Codes

static NSInteger const kStatusTeaPot = 418;

#endif /* EKNetworkingConstants_h */
