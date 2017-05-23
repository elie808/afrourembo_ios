//
//  EKCompanyServiceTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"

@protocol EKCompanyServiceCellDelegate <NSObject>
- (void)didTapBookButtonAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EKCompanyServiceTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property (assign, nonatomic) id<EKCompanyServiceCellDelegate> cellDelegate;

@property (strong, nonatomic) IBOutlet UIButton *cellBookButton;

@property (strong, nonatomic) IBOutlet UILabel *cellServiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellServiceLaborLabel;

- (void)configureEmptyCell;
- (void)configureCellForService:(Service *)serviceObj;

- (IBAction)didTapBookButton:(id)sender;

@end
