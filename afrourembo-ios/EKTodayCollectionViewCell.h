//
//  EKTodayCollectionViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"

@interface EKTodayCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellClientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellServiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cellStatusImageView;

- (void)configureCellForAppointment:(Appointment *)appointment;

@end
