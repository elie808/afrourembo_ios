//
//  EKBookingTimeCollectionViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingTimeCollectionViewCell.h"

@implementation EKBookingTimeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 6.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}


@end
