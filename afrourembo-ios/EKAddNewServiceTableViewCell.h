//
//  EKAddNewServiceTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKAddNewServiceTableViewCell : UITableViewCell

@property (weak, nonatomic) NSIndexPath *cellIndexPath;
@property (weak, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;

@end
