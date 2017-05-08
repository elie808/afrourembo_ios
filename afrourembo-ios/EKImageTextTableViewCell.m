//
//  EKImageTextTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKImageTextTableViewCell.h"

@implementation EKImageTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        
        self.cellTextLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.cellTextLabel.textColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
        
    } else {
        
        self.cellTextLabel.font = [UIFont systemFontOfSize:16];
        self.cellTextLabel.textColor = [UIColor colorWithRed:51./255. green:51./255. blue:51./255. alpha:1.0];
    }
}

@end
