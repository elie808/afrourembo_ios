//
//  EKBookingProCollectionViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingProCollectionViewCell.h"

@implementation EKBookingProCollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.cellImageBorder.backgroundColor = selected ? [UIColor orangeColor] : [UIColor clearColor];
}

- (void)configureCellWithPro:(Professional *)proObj {
    
    self.cellNameLabel.text = [NSString stringWithFormat:@"%@ %@", proObj.fName, proObj.lName];
    [self.cellImageView yy_setImageWithURL:[NSURL URLWithString:proObj.profilePicture] options:YYWebImageOptionProgressive];
}

@end
