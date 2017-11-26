//
//  EKCompanyProfessionalCollectionViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfessionalCollectionViewCell.h"

@implementation EKCompanyProfessionalCollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.cellImageBorder.backgroundColor = selected ? [UIColor orangeColor] : [UIColor clearColor];
}

@end
