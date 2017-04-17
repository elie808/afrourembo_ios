//
//  EKBookingDayCollectionViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingDayCollectionViewCell.h"

@implementation EKBookingDayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 6.0f;
    self.layer.borderColor = [UIColor colorWithRed:255./255. green:198./255. blue:0 alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    self.backgroundColor = selected ? [UIColor colorWithRed:255./255. green:198./255. blue:0 alpha:1.0] : [UIColor clearColor];
}

- (void)animateCell {
    
    void (^animateChangeWidth)() = ^()
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width*1.5, self.frame.size.height*1.5);
    };
    
    // Animate
    [UIView transitionWithView:self duration:0.1f options: UIViewAnimationOptionCurveLinear animations:animateChangeWidth completion:nil];
}

@end
