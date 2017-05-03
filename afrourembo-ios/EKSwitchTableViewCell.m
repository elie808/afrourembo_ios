//
//  EKSwitchTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSwitchTableViewCell.h"

@implementation EKSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)didChangeSwitchValue:(UISwitch *)cellSwitch {
    
    BOOL boolValue = cellSwitch.isOn ? YES : NO;
    
    [self didChangeSwitchValue:boolValue atIndex:self.cellIndexPath];
}

#pragma mark - EKSwitchCellDelegate

- (void)didChangeSwitchValue:(BOOL)switchValue atIndex:(NSIndexPath *)indexPath {
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChangeSwitchValue:atIndex:)]) {
        
        [self.delegate didChangeSwitchValue:switchValue atIndex:self.cellIndexPath];
    }
}

@end
