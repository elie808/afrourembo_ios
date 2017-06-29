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

- (void)configureLunchCellForDay:(Day *)dayModel forIndex:(NSIndexPath *)indexPath {
    
    self.cellIndexPath = indexPath;
    
    [self.cellSwitch setOn:dayModel.lunchBreakSelected];
    self.cellTitleLabel.text = @"Lunch break";
    
    if (dayModel.daySelected) {
        
        self.cellTitleLabel.textColor = [UIColor colorWithRed:51./255. green:51./255. blue:51./255. alpha:1.0];
        
    } else {
        
        self.cellTitleLabel.textColor = [UIColor colorWithRed:229./255. green:229./255. blue:229./255. alpha:1.0];
    }
}

- (void)configureCellForDay:(Day *)dayModel forIndex:(NSIndexPath *)indexPath {
    
    self.cellIndexPath = indexPath;
    
    [self.cellSwitch setOn:dayModel.daySelected];
    self.cellTitleLabel.text = [Day dayStringFromNumber:dayModel.day];
    
    if (dayModel.daySelected) {
        
        self.cellTitleLabel.textColor = [UIColor colorWithRed:51./255. green:51./255. blue:51./255. alpha:1.0];
        
    } else {
        
        self.cellTitleLabel.textColor = [UIColor colorWithRed:229./255. green:229./255. blue:229./255. alpha:1.0];
    }
}

#pragma mark - Actions

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
