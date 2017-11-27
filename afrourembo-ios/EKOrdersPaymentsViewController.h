//
//  EKOrdersPaymentsViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "EKRatingViewController.h"

#import "EKCartCollectionViewCell.h"
#import "ClientBooking.h"
#import "EKSettings.h"
#import "Customer+API.h"

#import "EKCartCollectionViewCell+Helpers.h"
#import "UIViewController+Helpers.h"

@interface EKOrdersPaymentsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, EKCartCollectionViewCellDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *emptyOrdersView;

- (IBAction)unwindToOrdersVC:(UIStoryboardSegue *)segue;

@end
