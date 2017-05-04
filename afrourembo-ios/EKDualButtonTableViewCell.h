//
//  EKDualButtonTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@protocol EKDualButtonCellDelegate <NSObject>
- (void)didTapLeftButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)didTapRightButtonAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EKDualButtonTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;

@property (assign, nonatomic) id<EKDualButtonCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)didTapLeftButton:(id)sender;
- (IBAction)didTapRightButton:(id)sender;

- (void)configureCellForService:(Day *)dayModel forIndex:(NSIndexPath *)indexPath;
- (void)configureCellForLunch:(Day *)dayModel forIndex:(NSIndexPath *)indexPath;

@end
