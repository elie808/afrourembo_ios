//
//  EKAccessoryTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKAccessoryCellDelegate <NSObject>
- (void)didTapAccessoryButtonAtIndex:(NSIndexPath *)indexPath;
@end

@interface EKAccessoryTableViewCell : UITableViewCell

@property (assign, nonatomic) id<EKAccessoryCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *cellIndexPath;

@property (strong, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *cellAccessoryButton;

@end
