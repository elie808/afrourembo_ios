//
//  EKSalonListTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKInCellCollectionView.h"

@interface EKSalonListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet EKInCellCollectionView *collectionView;

@end
