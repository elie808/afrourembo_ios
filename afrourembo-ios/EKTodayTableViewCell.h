//
//  EKTodayTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKInCellCollectionView.h"

@interface EKTodayTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellHourOfTheDayLabel;
@property (strong, nonatomic) IBOutlet EKInCellCollectionView *collectionView;

@end
