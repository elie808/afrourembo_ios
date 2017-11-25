//
//  EKCompanyReviewTableViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyReviewTableViewCell.h"

@implementation EKCompanyReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureEmptyCell {

    self.cellServiceLabel.text = @"";
    self.cellProfessionalLabel.text = @"";
    self.cellCustomerNameLabel.text = @"";
    self.cellDateLabel.text = @"";
    self.cellTextView.text = @"No Reviews";
    self.cellTextView.textColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
    self.cellStarsImageView.hidden = YES;
    self.cellCustomerImageView.hidden = YES;
}

- (void)configureCellForReview:(Review *)reviewObj {
    
    self.cellServiceLabel.text = reviewObj.serviceName;
    self.cellProfessionalLabel.text = @"by Professional name";
    self.cellCustomerNameLabel.text = [NSString stringWithFormat:@"%@ %@", reviewObj.reviewerFirstName, reviewObj.reviewerLastName];
    self.cellDateLabel.text = [NSDate stringFromDate:reviewObj.date withFormat:DateFormatLetterDayMonthYear];
    self.cellTextView.text = reviewObj.review;
    self.cellTextView.textColor = [UIColor colorWithRed:72./255. green:72./255. blue:72./255. alpha:1.0];
    self.cellStarsImageView.image = [UIImage imageForStars:reviewObj.rating];
    [self.cellCustomerImageView yy_setImageWithURL:[NSURL URLWithString:reviewObj.reviewerProfilePicture]
                                           options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
}

@end
