//
//  EKBookingViewController+CollectionView.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController.h"

@interface EKBookingViewController (CollectionView) <UICollectionViewDelegate, UICollectionViewDataSource>

/// convenience method to be called from EKBookingVC, to allow automatically selecting a professional when there's only one available
- (void)getDaysForPro:(Professional *)pro;

@end
