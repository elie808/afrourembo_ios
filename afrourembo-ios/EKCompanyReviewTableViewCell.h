//
//  EKCompanyReviewTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"
#import "UIImage+Helpers.h"
#import <YYWebImage/YYWebImage.h>

@interface EKCompanyReviewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cellServiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellProfessionalLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellCustomerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellDateLabel;

@property (strong, nonatomic) IBOutlet UITextView *cellTextView;

@property (strong, nonatomic) IBOutlet UIImageView *cellStarsImageView;
@property (strong, nonatomic) IBOutlet UIImageView *cellCustomerImageView;

- (void)configureEmptyCell;
- (void)configureCellForReview:(Review *)reviewObj;

@end
