//
//  EKConstants.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#ifndef EKConstants_h
#define EKConstants_h

#pragma mark - Storyboard IDs

static NSString * const kSplashVC = @"splashVC";
static NSString * const kExploreVC = @"exploreVC";
static NSString * const kVendorDashVC = @"vendor_dashboard";

#pragma mark - Storyboard IDs

static NSInteger const kTodayVCIndex = 0;
static NSInteger const kScheduleVCIndex  = 1;
static NSInteger const kDashboardVCIndex = 2;
static NSInteger const kClientsVCIndex   = 3;
static NSInteger const kSettingsVCIndex  = 4;

#pragma mark - In-app constants

static NSString * const kProfessionalType = @"professional";
static NSString * const kSalonType = @"salon";

#pragma mark - Image Names

#pragma mark - Animations

static CGFloat const kLeftPushAnimationDuration = 0.25;

// cards
static CGFloat const kSwipeOutAnimationDuration = 0.40;
static CGFloat const kResetAnimationDuration = 0.30;

#pragma mark - Other

static NSString * const kCurrency = @"KES";

static NSString * const kDashboardNotification = @"dashboardNotificationKey";
static NSString * const kDashObjKey = @"dashboardItemsKey";

#endif /* EKConstants_h */
