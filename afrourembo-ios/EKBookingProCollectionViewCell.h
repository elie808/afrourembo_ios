//
//  EKBookingProCollectionViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Professional.h"
#import <YYWebImage/YYWebImage.h>

@interface EKBookingProCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cellImageView;
@property (strong, nonatomic) IBOutlet UIView *cellImageBorder;
@property (strong, nonatomic) IBOutlet UILabel *cellNameLabel;

- (void)configureCellWithPro:(Professional *)proObj;

@end
