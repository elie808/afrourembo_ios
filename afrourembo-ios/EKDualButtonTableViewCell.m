//
//  EKDualButtonTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDualButtonTableViewCell.h"

@implementation EKDualButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)didTapLeftButton:(id)sender {
    
    [self didTapLeftButtonAtIndexPath:self.cellIndexPath];
}

- (IBAction)didTapRightButton:(id)sender {
    
    [self didTapRightButtonAtIndexPath:self.cellIndexPath];
}

#pragma mark - EKDualButtonCellDelegate

- (void)didTapLeftButtonAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didTapRightButtonAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end