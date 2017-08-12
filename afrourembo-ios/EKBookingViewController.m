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

//static NSString * const kPlaceHolderText = @"What do you like about this place?";
static CGFloat const kContainerViewHeight = 128;

@implementation EKBookingViewController {
    BOOL _keyboardShowing;

    NSMutableArray *_daysDataSource;
    NSMutableArray *_timesDataSource;
    NSString *_vendorType;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //TODO: ADD IF STATEMENT AND CHANGE TYPE ACCORDING TO VIEW MODE
    _vendorType = kProfessionalType;
    
    self.booking = [Booking new];
    
    _daysDataSource = [NSMutableArray new];
    _timesDataSource = [NSMutableArray new];
    
    self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kContainerViewHeight);
    [self.view addSubview:self.containerView];
    self.containerView.hidden = YES;
    //    self.textView.text = kPlaceHolderText;
    
    [self populateDays];
    [self populateDayWithTimes:@9 endingHour:@18 inMinuteIncrements:@15];
}

- (void)populateDays {

    for (int i = 0; i < 30; i++) {
    
        [_daysDataSource addObject:[NSDate stringFromDate:[NSDate addDays:i after:[NSDate todayDate]]
                                               withFormat:DateFormatLetterDayMonthYear]];
    }
}

//TODO: Add support to many unavailable hours, and include minutes
- (void)populateDayWithTimes:(NSNumber *)startHour endingHour:(NSNumber *)endHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    for (int hour = [startHour intValue]; hour < [endHour intValue]; hour++) {
    
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {

            BOOL isAvailable;
            
            if ( hour > 13 && hour < 15 ) { isAvailable = NO; } else { isAvailable = YES; }
            
                TimeSlot *slot = [[TimeSlot alloc] initWithDate:[NSDate todayAtTime:[NSNumber numberWithInt:hour]
                                                                           minutes:[NSNumber numberWithInt:startingMin]]
                                               andAvailability:isAvailable];

                [_timesDataSource addObject:slot];
        }
    }
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.proCollectionView) {
        return self.professionalsDataSource.count;
    }
    
    if (collectionView == self.dayCollectionView) {
        return _daysDataSource.count;
    }
    
    if (collectionView == self.timeCollectionView) {
        return _timesDataSource.count;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == self.proCollectionView) {

        EKBookingProCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProCell forIndexPath:indexPath];

        Professional *pro = self.professionalsDataSource[indexPath.row];
        
        [cell configureCellWithPro:pro];
        
        return cell;
    }
    
    if (collectionView == self.dayCollectionView) {
     
        EKBookingDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCell forIndexPath:indexPath];
        
        cell.cellDayLabel.text = _daysDataSource[indexPath.row];
        
        return cell;
    }
    
    if (collectionView == self.timeCollectionView) {
        
        EKBookingTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTimeCell forIndexPath:indexPath];
        
        TimeSlot *timeSlot = _timesDataSource[indexPath.row];
        
        [cell configureCell:timeSlot];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    if (collectionView == self.proCollectionView) {
     
        Professional *pro = self.professionalsDataSource[indexPath.row];
        
        [Booking getBookingsForVendor:pro.professionalID
                               ofType:_vendorType
                            withToken:[EKSettings getSavedCustomer].token
                            withBlock:^(NSArray *array) {
                                
                            }
                           withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                               
                               [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                           }];
    }
    
    if (collectionView == self.dayCollectionView) {
     
        // ANIMATE CELL TO GROW
        // Prepare for animation
//        [collectionView.collectionViewLayout invalidateLayout];
//        EKBookingDayCollectionViewCell *__weak cell = (EKBookingDayCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath]; // Avoid retain cycles

//        [cell animateCell];
    }
    
    if (collectionView == self.timeCollectionView) {
     
        TimeSlot *timeSlot = _timesDataSource[indexPath.row];
        
        if (timeSlot.isAvailable) {
            timeSlot.isSelected = !timeSlot.isSelected;
            [self.timeCollectionView reloadData];
        }
        
//        timeSlot.isSelected = !timeSlot.isSelected;
//        [self.timeCollectionView reloadData];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    self.booking.bookingDescription = textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
//    if ( [textView.text isEqualToString:kPlaceHolderText] ) {
//        
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor];
//    }
//    
//    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
//    if ([textView.text isEqualToString:@""] || textView.text.length == 0) {
//        
//        textView.text = kPlaceHolderText;
//        textView.textColor = [UIColor lightGrayColor];
//    }
//    
//    [textView resignFirstResponder];
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
            
            self.containerView.frame = CGRectMake(0,
                                                  self.view.frame.size.height - (keyboardSize.height + kContainerViewHeight),
                                                  self.view.frame.size.width,
                                                  kContainerViewHeight);
            
            _keyboardShowing = YES;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    if (_keyboardShowing) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kContainerViewHeight);;
            self.containerView.hidden = YES;
            _keyboardShowing = NO;
        }];
    }
}

@end
