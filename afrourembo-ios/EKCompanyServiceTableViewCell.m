//
//  EKCompanyServiceTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyServiceTableViewCell.h"

@implementation EKCompanyServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureEmptyCell {
    
    self.cellBookButton.hidden = YES;
    self.cellServiceLabel.text = @"";

    self.cellServiceLaborLabel.textColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
    self.cellServiceLaborLabel.text = @"There are no services yet.";
}

- (void)configureCellForService:(Service *)serviceObj {
    
    self.cellServiceLabel.text = serviceObj.serviceTitle;
    self.cellServiceLaborLabel.text = [NSString stringWithFormat:@"$%.2f for %.f mins",
                                       serviceObj.servicePrice, serviceObj.serviceLaborTime];
}

- (IBAction)didTapBookButton:(id)sender {
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(didTapBookButtonAtIndexPath:)]) {
        
        [self.cellDelegate didTapBookButtonAtIndexPath:self.cellIndexPath];
    }
}

@end
