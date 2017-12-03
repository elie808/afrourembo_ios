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

#pragma mark - Helpers

- (void)configureCellWithJoinRequest:(JoinSalonRequest *)request atIndexPath:(NSIndexPath *)indexPath withDelegate:(id<EKManageStaffCellDelegate>)delegate {
    
    self.cellDelegate = delegate;
    self.cellIndexPath = indexPath;
    
    self.cellProfessionalNameLabel.text = [NSString stringWithFormat:@"%@ %@", request.professional.fName, request.professional.lName];
    self.cellEmailLabel.text = request.professional.phone;
    [self.cellImageView yy_setImageWithURL:[NSURL URLWithString:request.professional.profilePicture] options:YYWebImageOptionProgressive];
}

- (void)configureCellWithProfessional:(Professional *)proObj atIndexPath:(NSIndexPath *)indexPath withDelegate:(id<EKManageStaffCellDelegate>)delegate {
    
    self.cellDelegate = delegate;
    self.cellIndexPath = indexPath;
    
    self.cellProfessionalNameLabel.text = [NSString stringWithFormat:@"%@ %@", proObj.fName, proObj.lName];
    self.cellEmailLabel.text = proObj.phone;
    [self.cellImageView yy_setImageWithURL:[NSURL URLWithString:proObj.profilePicture] options:YYWebImageOptionProgressive];
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
