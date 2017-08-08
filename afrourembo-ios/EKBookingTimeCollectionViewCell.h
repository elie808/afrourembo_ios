//
//  EKBookingTimeCollectionViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSlot.h"

@interface EKBookingTimeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellTimeLabel;

- (void)configureCell:(TimeSlot *)slot;

@end
