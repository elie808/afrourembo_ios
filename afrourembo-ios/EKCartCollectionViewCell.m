//
//  EKCartCollectionViewCell.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCartCollectionViewCell.h"

@implementation EKCartCollectionViewCell

- (void)didTapEditButtonAtIndex:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapEditButtonAtIndex:)]) {
        [self.delegate didTapEditButtonAtIndex:indexPath];
    }
}

- (IBAction)didTapEditButton:(id)sender {
    [self didTapEditButtonAtIndex:self.cellIndexPath];
}

@end
