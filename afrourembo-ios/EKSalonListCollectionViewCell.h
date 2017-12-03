//
//  EKSalonListCollectionViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKSalonListCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellStartHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellEndHourLabel;

@end
