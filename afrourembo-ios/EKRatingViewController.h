//
//  EKRatingViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 11/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientBooking.h"
#import "EKSettings.h"
#import "HCSStarRatingView.h"

#import "Review+API.h"
#import "UIViewController+Helpers.h"

@interface EKRatingViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) ClientBooking *passedBooking;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *ratingSlider;

@property (strong, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *salonNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *professionalNameLabel;

@property (strong, nonatomic) IBOutlet UITextField *reviewTextField;

@end
