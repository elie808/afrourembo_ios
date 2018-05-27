//
//  EKSalonStaffTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>
#import "StaffPayment.h"

@interface EKSalonStaffTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

- (void)configureWith:(StaffPayment *)staff;

@end
