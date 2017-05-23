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

    self.cellTextView.textColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
    self.cellTextView.text = @"There are no services yet.";    
}

- (void)configureCellForReview:(Review *)reviewObj {
    
    self.cellServiceLabel.text = reviewObj.reviewTitle;
    self.cellProfessionalLabel.text = reviewObj.reviewProfessional;
    self.cellCustomerNameLabel.text = reviewObj.reviewAuthor;
    self.cellDateLabel.text = reviewObj.reviewDate;
    self.cellTextView.text = reviewObj.reviewText;
    self.cellStarsImageView.image = [UIImage imageForStars:reviewObj.reviewStars];
    self.cellCustomerImageView.image = [UIImage imageNamed:reviewObj.reviewProfessionalImage];
}

@end
