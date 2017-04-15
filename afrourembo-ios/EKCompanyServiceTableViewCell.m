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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapBookButton:(id)sender {
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(didTapBookButtonAtIndexPath:)]) {
        
        [self.cellDelegate didTapBookButtonAtIndexPath:self.cellIndexPath];
    }
}

@end
