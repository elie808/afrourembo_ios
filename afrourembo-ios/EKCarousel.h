//
//  EKCarousel.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>

@interface EKCarousel : UIScrollView

/// takes an NSArray of picture URLs
- (void)configureWithVenueImages:(NSArray *)venueImagesURLs;

@end
