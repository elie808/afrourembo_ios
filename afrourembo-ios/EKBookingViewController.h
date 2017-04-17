//
//  EKBookingViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKBookingProCollectionViewCell.h"

@interface EKBookingViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *proCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *dayCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *timeCollectionView;

@end
