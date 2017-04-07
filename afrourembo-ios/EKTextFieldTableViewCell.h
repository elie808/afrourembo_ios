//
//  EKTextFieldTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKTextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *cellTextField;

@end
