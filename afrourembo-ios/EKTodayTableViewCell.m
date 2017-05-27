//
//  EKTodayTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKTodayTableViewCell.h"

@implementation EKTodayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Add upper border to collectionVIew
    CALayer *upperBorder = [CALayer layer];
    upperBorder.backgroundColor = [[UIColor colorWithRed:229./255. green:229./255. blue:229./255. alpha:1.0] CGColor];
    upperBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 1.0f);
    [self.collectionView.layer addSublayer:upperBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
