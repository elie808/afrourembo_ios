//
//  EKTodayViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/26/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKTodayViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
