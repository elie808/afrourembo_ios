//
//  EKCompanyProfileViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKCompanyServiceTableViewCell.h"
#import "EKCompanyReviewTableViewCell.h"
#import "EKCompanyProfessionalTableViewCell.h"
#import "EKCompanyContactTableViewCell.h"

#import "EKInCellCollectionView.h"
#import "EKCompanyProfessionalCollectionViewCell.h"

@interface EKCompanyProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
