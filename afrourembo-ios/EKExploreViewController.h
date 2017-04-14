//
//  EKExploreViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKExploreCollectionViewCell.h"
#import "Service.h"

@interface EKExploreViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)unwindToExploreVC:(UIStoryboardSegue *)segue;

@end
