//
//  EKManageStaffTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKManageStaffTableViewCell.h"

@implementation EKManageStaffTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Actions

- (IBAction)didTapAcceptButton:(UIButton *)sender {
    
    [self acceptStaffAtIndex:self.cellIndexPath];
}

- (IBAction)didTapDeclineButton:(UIButton *)sender {
    
    [self declineStaffAtIndex:self.cellIndexPath];
}

#pragma mark - EKManageStaffCellDelegate

- (void)acceptStaffAtIndex:(NSIndexPath *)indexPath {
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(acceptStaffAtIndex:)]) {
        [self.cellDelegate acceptStaffAtIndex:indexPath];
    }
}

- (void)declineStaffAtIndex:(NSIndexPath *)indexPath {
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(declineStaffAtIndex:)]) {
        [self.cellDelegate declineStaffAtIndex:indexPath];
    }
}

@end
