//
//  EKCartViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKSettings.h"
#import "EKCartCollectionViewCell.h"

#import "Reservation+API.h"
#import "Booking.h"

#import "EKCartCollectionViewCell+Helpers.h"
#import "UIViewController+Helpers.h"

#import <Realm/Realm.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface EKCartViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, EKCartCollectionViewCellDelegate>

//@property (strong, nonatomic) Booking *passedBooking;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *emptyCartView;
@property (strong, nonatomic) IBOutlet UIView *bottomBar;

- (IBAction)didTapCheckoutButton:(UIButton *)button;

@end
