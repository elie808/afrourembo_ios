//
//  EKCartCollectionViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKCartCollectionViewCellDelegate <NSObject>
- (void)didTapEditButtonAtIndex:(NSIndexPath *)indexPath;
@end

@interface EKCartCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<EKCartCollectionViewCellDelegate> delegate;
@property (weak, nonatomic) NSIndexPath *cellIndexPath;

@property (weak, nonatomic) IBOutlet UILabel *bookingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingVendorLabel;
@property (weak, nonatomic) IBOutlet UILabel *practionnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingDescriptionLabel;

- (IBAction)didTapEditButton:(id)sender;

@end
