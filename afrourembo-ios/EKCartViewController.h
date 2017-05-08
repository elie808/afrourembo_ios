//
//  EKCartViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Booking.h"
#import "EKCartCollectionViewCell.h"
#import "EKCartCollectionViewCell+Helpers.h"

@interface EKCartViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, EKCartCollectionViewCellDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *bottomBar;

- (IBAction)didTapCheckoutButton:(UIButton *)button;

@end
