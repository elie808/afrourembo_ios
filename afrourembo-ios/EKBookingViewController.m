//
//  EKBookingViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController.h"

static NSString * const kProCell = @"bookingProfessionalCell";
static NSString * const kDayCell = @"bookingDayCell";
static NSString * const kTimeCell = @"bookingTimeCell";

@implementation EKBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (collectionView == self.proCollectionView) {
        return 1;
    }
    
    if (collectionView == self.dayCollectionView) {
        return 1;
    }
    
    if (collectionView == self.timeCollectionView) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.proCollectionView) {
        return 9;
    }
    
    if (collectionView == self.dayCollectionView) {
        return 30;
    }
    
    if (collectionView == self.timeCollectionView) {
        return 30;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == self.proCollectionView) {

        EKBookingProCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProCell forIndexPath:indexPath];
        
        return cell;
    }
    
    if (collectionView == self.dayCollectionView) {
     
        EKBookingDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCell forIndexPath:indexPath];
        
        return cell;
    }
    
    if (collectionView == self.timeCollectionView) {
        
        EKBookingTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTimeCell forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    if (collectionView == self.proCollectionView) {
     
    }
    
    if (collectionView == self.dayCollectionView) {
     
        // ANIMATE CELL TO GROW
        // Prepare for animation
//        [collectionView.collectionViewLayout invalidateLayout];
//        EKBookingDayCollectionViewCell *__weak cell = (EKBookingDayCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath]; // Avoid retain cycles

//        [cell animateCell];
    }
    
    if (collectionView == self.timeCollectionView) {
     
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - Helpers

- (void)initGestureRecognizer {
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeCollecitonView:)];
    panRecognizer.delegate = self;
    [self.timeCollectionView addGestureRecognizer:panRecognizer];
}

- (IBAction)didSwipeCollecitonView:(UIPanGestureRecognizer *)gesture {
    
    NSLog(@"SWIPING");
    
    CGFloat swipeSensitivity = 20.0;
    CGPoint translation = [gesture translationInView:self.timeCollectionView];
    
    if ( fabs(translation.x) > swipeSensitivity) {
        
        switch (gesture.state) {
                
            case UIGestureRecognizerStateBegan: {
                
            } break;
                
            case UIGestureRecognizerStateChanged: {
                
            } break;
                
            case (UIGestureRecognizerStateEnded): {
                
            } break;
                
            case UIGestureRecognizerStateCancelled:{
                
            } break;
                
            default: break;
        }
    }
}

@end
