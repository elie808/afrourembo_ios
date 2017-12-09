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
static NSString * const kUserBookingsAPIPath = @"user/bookings";
static NSString * const kUserExploreAPIPath  = @"user/explore";
static NSString * const kUserFavoritesAPIPath  = @"user/favorites";
static NSString * const kUserDeleteFavoritesAPIPath = @"user/favorites/:id";
static NSString * const kUserFBRegisterAPIPath = @"user/facebook/register";
static NSString * const kUserFBLoginAPIPath    = @"user/facebook/login";
static NSString * const kUserLoginAPIPath    = @"user/login";
static NSString * const kUserProfileAPIPath  = @"user/profile";
static NSString * const kUserReviewsAPIPath  = @"user/reviews/:id";
static NSString * const kUserPOSTReviewsAPIPath  = @"user/reviews";
static NSString * const kUserPassResetAPIPath  = @"user/password/reset";
static NSString * const kUserProfessionalBookingsAPIPath = @"user/vendor/:userId/bookings";
static NSString * const kUserProfilePictureAPIPath      = @"user/profile/picture";
static NSString * const kUserProfessionalProfileAPIPath = @"user/professionals/:userId/profile";
static NSString * const kUserReservationsAPIPath        = @"user/reservations";
static NSString * const kUserVendorAvailabilityAPIPath  = @"user/professional/:userId/availability";
static NSString * const kUserExploreProfessionalsAPIPath  = @"user/explore/professionals";
static NSString * const kUserExploreSalonsAPIPath  = @"user/explore/salons";

static NSString * const kProfessionalAvailabilityAPIPath = @"professional/availability";
static NSString * const kProfessionalClientsAPIPath      = @"professional/clients";
static NSString * const kProfessionalDashboardAPIPath    = @"professional/dashboard";
static NSString * const kProfessionalInfoAPIPath         = @"professional/business";
static NSString * const kProfessionalFBRegisterAPIPath = @"professional/facebook/register";
static NSString * const kProfessionalFBLoginAPIPath  = @"professional/facebook/login";
static NSString * const kProfessionalRegisterAPIPath = @"professional/register";
static NSString * const kProfessionalLoginAPIPath    = @"professional/login";
static NSString * const kProfessionalPassResetAPIPath = @"professional/password/reset";
static NSString * const kProfessionalProfileAPIPath  = @"professional/profile";
static NSString * const kProfessionalPictureAPIPath  = @"professional/profile/picture";
static NSString * const kProfessionalPortfolioAPIPath   = @"professional/portfolio";
static NSString * const kProfessionalDeletePortfolioAPIPath   = @"professional/portfolio/:id";
static NSString * const kProfessionalDeleteServiceAPIPath     = @"professional/services/:id";
static NSString * const kProfessionalServiceAPIPath  = @"professional/services";
static NSString * const kProfessionalJoinSalonAPIPath = @"professional/salon/:id/join";

static NSString * const kSalonRegisterAPIPath  = @"salon/register";
static NSString * const kSalonFBRegisterAPIPath= @"salon/facebook/register";
static NSString * const kSalonLoginAPIPath     = @"salon/login";
static NSString * const kSalonPassResetAPIPath = @"salon/password/reset";
static NSString * const kSalonInfoAPIPath      = @"salon/business";
static NSString * const kSalonStaffAPIPath     = @"salon/:userId/professionals";
static NSString * const kSalonJoinRequestsAPIPath = @"salon/join/requests";
static NSString * const kSalonCurrentStaffAPIPath = @"salon/staff";
static NSString * const kSalonDeleteStaffAPIPath  = @"salon/staff/:id";
static NSString * const kSalonDashboardAPIPath = @"salon/dashboard";
static NSString * const kSalonClientsAPIPath   = @"salon/clients";

#pragma mark - Status Codes

static NSInteger const kStatusTeaPot = 418;

#endif /* EKNetworkingConstants_h */
