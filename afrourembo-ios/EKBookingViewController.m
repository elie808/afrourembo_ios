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

static NSString * const kCartSegue = @"bookingTimeToCartVC";

@implementation EKBookingViewController {
    BOOL _keyboardShowing;
    CGFloat _containerViewHeight;
    
    NSMutableArray *_prosDataSource;
    NSMutableArray *_daysDataSource;
    NSMutableArray *_timesDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.booking = [Booking new];
    
//    _prosDataSource;
//    _daysDataSource;
//    _timesDataSource
    
    _containerViewHeight = 200;
    self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, _containerViewHeight);
    [self.view addSubview:self.containerView];
    
    self.containerView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)textViewDidChange:(UITextView *)textView {

    self.booking.bookingDescription = textView.text;
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

#pragma mark - Actions

- (IBAction)didTapNextButton:(UIBarButtonItem *)sender {

    [self performSegueWithIdentifier:kCartSegue sender:nil];
}

- (IBAction)didTapAddNoteButton:(id)sender {
    
    self.containerView.hidden = NO;
    [self.textView becomeFirstResponder];
}

- (IBAction)didTapDoneButton:(id)sender {
    
    [self.textView resignFirstResponder];
    self.containerView.hidden = YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kCartSegue]) {
        
        EKCartViewController *vc = segue.destinationViewController;
        vc.passedBooking = self.booking;
    }
}

#pragma mark - Helpers

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (!_keyboardShowing) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.containerView.hidden = NO;
            
            self.containerView.frame = CGRectMake(0, keyboardSize.height,
                                                  self.view.frame.size.width,
                                                  self.textView.frame.size.height);
            _keyboardShowing = YES;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    if (_keyboardShowing) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, _containerViewHeight);;
            self.containerView.hidden = YES;
            _keyboardShowing = NO;
        }];
    }
}

@end
