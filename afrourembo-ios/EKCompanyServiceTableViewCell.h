//
//  EKCompanyServiceTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKCompanyServiceCellDelegate <NSObject>
- (void)didTapBookButtonAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EKCompanyServiceTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property (assign, nonatomic) id<EKCompanyServiceCellDelegate> cellDelegate;

@property (strong, nonatomic) IBOutlet UIButton *cellBookButton;

@property (strong, nonatomic) IBOutlet UILabel *cellServiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellServiceLaborLabel;

- (IBAction)didTapBookButton:(id)sender;

@end
