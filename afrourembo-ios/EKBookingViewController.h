//
//  EKBookingViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <STPopup/STPopup.h>
#import <Realm/Realm.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "EKCartViewController.h"

#import "EKBookingProCollectionViewCell.h"
#import "EKBookingDayCollectionViewCell.h"
#import "EKBookingTimeCollectionViewCell.h"

#import "TimeSlot.h"
#import "Booking.h"
#import "Service.h"
#import "Professional.h"

#import "EKSettings.h"
#import "EKConstants.h"

#import "Booking+API.h"
#import "Reservation+API.h"
#import "NSDate+Helpers.h"
#import "UIViewController+Helpers.h"

@interface EKBookingViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UITextViewDelegate>

//@property (strong, nonatomic) Booking *booking;
@property (strong, nonatomic) Service *passedService;
@property (strong, nonatomic) NSArray *professionalsDataSource;

@property (strong, nonatomic) IBOutlet UIView *emptyTimeDataView;

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UICollectionView *proCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *dayCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *timeCollectionView;

- (IBAction)didTapNextButton:(UIBarButtonItem *)sender;
- (IBAction)didTapAddNoteButton:(id)sender;
- (IBAction)didTapDoneButton:(id)sender;

@end
