//
//  EKFilterSearchTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKFilterSearchTableViewCell.h"

@implementation EKFilterSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        
        self.cellTextLabel.textColor = [UIColor whiteColor];
        self.cellTextLabel.font = [UIFont boldSystemFontOfSize:14];
        self.backgroundColor = [UIColor colorWithRed:255./255. green:195./255. blue:0/255. alpha:1.0];
        
    } else {
        
        self.cellTextLabel.textColor = [UIColor colorWithRed:51./255. green:51./255. blue:51./255. alpha:1.0];
        self.cellTextLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
