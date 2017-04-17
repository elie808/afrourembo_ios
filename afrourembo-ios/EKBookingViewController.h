//
//  EKBookingViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKBookingProCollectionViewCell.h"
#import "EKBookingDayCollectionViewCell.h"
#import "EKBookingTimeCollectionViewCell.h"

@interface EKBookingViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *proCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *dayCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *timeCollectionView;

@end
