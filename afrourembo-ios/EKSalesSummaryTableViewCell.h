//
//  EKSalesSummaryTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKSalesSummaryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellLeftTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellLeftValueLabel;

@property (strong, nonatomic) IBOutlet UILabel *cellRightTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellRightValueLabel;

@end
