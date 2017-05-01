//
//  EKAccessoryTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKAccessoryTableViewCell.h"

@implementation EKAccessoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Actions

- (IBAction)didTapAccessory:(UIButton *)sender {
    [self didTapAccessoryButtonAtIndex:self.cellIndexPath];
}

#pragma mark - EKAccessoryCellDelegate

- (void)didTapAccessoryButtonAtIndex:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapAccessoryButtonAtIndex:)]) {
        [self.delegate didTapAccessoryButtonAtIndex:indexPath];
    }
}

@end
