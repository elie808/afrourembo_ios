//
//  EKCarousel.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCarousel.h"

@implementation EKCarousel

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setContentOffset:CGPointMake(0, 0)];
}

- (void)configureWithVenueImages:(NSArray *)venueImagesURLs {
    
    if (venueImagesURLs && venueImagesURLs.count > 0) {
        
        // Set correct scrollView width
        self.contentSize = CGSizeMake(self.frame.size.width * (venueImagesURLs.count+1), self.frame.size.height);
        
        // Populate with images
        for (int i = 0; i < venueImagesURLs.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0,
                                                                                   self.frame.size.width, self.frame.size.height)];
            [self addSubview:imageView];
            
            // Load Image from URL
            __weak UIImageView *weakImage = imageView;
            [weakImage yy_setImageWithURL:[NSURL URLWithString:venueImagesURLs[i]]
                                  options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        }
    }
    
    [self layoutIfNeeded];
}

@end
