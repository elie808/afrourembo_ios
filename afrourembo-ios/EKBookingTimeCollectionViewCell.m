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
    
    [self cellDeselectedUI];
}

- (void)configureCell:(TimeSlot *)slot {
    
    self.cellTimeLabel.text = slot.hourString;
    
    if (slot.isAvailable) {
        
        if (slot.isSelected) { [self cellSelectedUI]; } else { [self cellDeselectedUI]; }
    
    } else {
    
        [self cellUnavailable];
    }
}

- (void)cellSelectedUI {
    
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 6.0f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.cellTimeLabel.alpha = 1.0;
    self.cellTimeLabel.textColor = [UIColor whiteColor];
    self.cellTimeLabel.font = [UIFont boldSystemFontOfSize:17.0];
    self.backgroundColor = [UIColor colorWithRed:255./255. green:203./255. blue:66./255. alpha:1.0];
}

- (void)cellDeselectedUI {
    
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 6.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.cellTimeLabel.alpha = 1;
    self.cellTimeLabel.textColor = [UIColor whiteColor];
    self.cellTimeLabel.font = [UIFont systemFontOfSize:17.0];
    self.backgroundColor = [UIColor colorWithRed:255./255. green:195./255. blue:50./255. alpha:1.0];
}

- (void)cellUnavailable {
    
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 6.0f;
    self.layer.borderColor = [UIColor clearColor].CGColor;

    self.cellTimeLabel.alpha = 0.5;
    self.cellTimeLabel.font = [UIFont systemFontOfSize:17.0];
    self.cellTimeLabel.textColor = [UIColor colorWithRed:229./255. green:229./255. blue:229./255. alpha:1.0];
    self.backgroundColor = [UIColor colorWithRed:255./255. green:203./255. blue:66./255. alpha:1.0];
}

@end
