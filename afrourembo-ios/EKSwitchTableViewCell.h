//
//  EKSwitchTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKSwitchCellDelegate <NSObject>
- (void)didChangeSwitchValue:(BOOL)switchValue atIndex:(NSIndexPath *)indexPath;
@end

@interface EKSwitchTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property (assign, nonatomic) id<EKSwitchCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UISwitch *cellSwitch;

@end
