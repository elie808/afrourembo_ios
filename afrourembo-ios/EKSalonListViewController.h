//
//  EKSalonListViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKSalonListTableViewCell.h"
#import "EKSalonListCollectionViewCell.h"
#import "Salon.h"

@interface EKSalonListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
