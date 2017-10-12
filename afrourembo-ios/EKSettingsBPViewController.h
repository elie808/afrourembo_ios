//
//  EKSettingsBPViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKCompanyProfessionalCollectionViewCell.h"
#import "EKSettings.h"

@interface EKSettingsBPViewController : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *tableViewDataSource;
@property (strong, nonatomic) NSArray *collectionViewDataSource;

- (IBAction)didTapLogOutButton:(id)sender;

@end
