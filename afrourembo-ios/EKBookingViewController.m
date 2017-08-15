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
    NSString *_bookingNote;
    NSDate *_selectedFromDate;
    NSDate *_selectedToDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //TODO: ADD IF STATEMENT AND CHANGE TYPE ACCORDING TO VIEW MODE
    _vendorType = kProfessionalType;
    
    // init data source
    _daysDataSource     = [NSMutableArray new];
    _timesDataSource    = [NSMutableArray new];
    _selectedFromDate   = nil;
    _selectedToDate     = nil;
    _bookingNote        = @"No notes";
    
    self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kContainerViewHeight);
    [self.view addSubview:self.containerView];
    self.containerView.hidden = YES;
    //    self.textView.text = kPlaceHolderText;
    
    self.emptyTimeDataView.frame = CGRectMake(self.timeCollectionView.frame.origin.x, self.timeCollectionView.frame.origin.y,
                                              self.timeCollectionView.frame.size.width, self.timeCollectionView.frame.size.height);
    self.emptyTimeDataView.hidden = NO;
    [self.view addSubview:self.emptyTimeDataView];
}

- (void)populateDays {

    for (int i = 0; i < 10; i++) {
    
        [_daysDataSource addObject:[NSDate stringFromDate:[NSDate addDays:i after:[NSDate todayDate]]
                                               withFormat:DateFormatLetterDayMonthYear]];
    }
}

//TODO: Add support to many unavailable hours, and include minutes
- (void)populateDayWithTimes:(NSNumber *)startHour endingHour:(NSNumber *)endHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    //TODO: mark hours up to now as unavailable

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

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Day getAvailabilityOfVendor:pro.professionalID
                              ofType:_vendorType
                           withToken:[EKSettings getSavedCustomer].token
                           withBlock:^(NSArray *daysArray) {
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               
                                self.emptyTimeDataView.hidden = YES;
                               
                                [self populateDays];
                                [self populateDayWithTimes:@9 endingHour:@18 inMinuteIncrements:@15];
                                [self.dayCollectionView reloadData];
                                [self.timeCollectionView reloadData];
                               //TODO: Update available days datasource
                               // modify populateDays method to take in day numbers and unavailable days
                           }
                          withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              
                              self.emptyTimeDataView.hidden = NO;
                          }];
    }
    
    if (collectionView == self.dayCollectionView) {
        
    }
    
    if (collectionView == self.timeCollectionView) {

        TimeSlot *timeSlot = _timesDataSource[indexPath.row];
        
        // compute how many days ahead to highlight
        int daysAhead = self.passedService.time / 15;
        
        if (timeSlot.isAvailable && (indexPath.row + daysAhead) < _timesDataSource.count) {

            // check if slots to be selected, don't overlap with unavailable slots
            BOOL allSlotsAheadAvailable = YES;
            for (int i = 0; i <= daysAhead; i++) {
                
                TimeSlot *nextSlot = _timesDataSource[indexPath.row+i];
                if (!nextSlot.isAvailable) {
                    allSlotsAheadAvailable = NO;
                    i = daysAhead;
                }
            }

            // deselect all slots
            for (int j = 0; j < _timesDataSource.count; j++) {
                TimeSlot *timeSlot = _timesDataSource[j];
                timeSlot.isSelected = NO;
            }
            
            // highlight needed cells
            if (allSlotsAheadAvailable) {
                
                // nullify selected dates from before
                _selectedFromDate   = nil;
                _selectedToDate     = nil;
                
                for (int i = 0; i <= daysAhead; i++) {
                    TimeSlot *nextSlot = _timesDataSource[indexPath.row+i];
                    nextSlot.isSelected = YES;
                }
                
                _selectedFromDate   = ((TimeSlot *)(_timesDataSource[indexPath.row])).date;
                _selectedToDate     = ((TimeSlot *)(_timesDataSource[indexPath.row+daysAhead])).date;
            }
        }

        [self.timeCollectionView reloadData];
    }
}

// center solo cells
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (collectionView == self.proCollectionView && self.professionalsDataSource.count <= 1) {
        
        return UIEdgeInsetsMake(0, (self.view.frame.size.width/2) - 55., 0, 0);
        
    } else {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    _bookingNote = textView.text;
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

    Professional *pro = self.professionalsDataSource[0];
    
    Reservation *reservationObj = [Reservation new];
    reservationObj.actorId      = pro.professionalID;
    reservationObj.serviceId    = self.passedService.serverServiceId;
    reservationObj.fromDateTime = _selectedFromDate;
    reservationObj.toDateTime   = _selectedToDate;
    reservationObj.type = _vendorType;
    reservationObj.note = _bookingNote;
    
    Booking *booking1 = [Booking new];
    booking1.bookingTitle = self.passedService.serviceName;
    booking1.bookingCost = [NSString stringWithFormat:@"%.0f %@", self.passedService.price, self.passedService.currency];
    booking1.bookingVendor = [NSString stringWithFormat:@"%@ %@", pro.fName, pro.lName]; //TODO: or salon name
    booking1.practionner = [NSString stringWithFormat:@"%@ %@", pro.fName, pro.lName];
    booking1.bookingDate = [NSDate stringFromDate:reservationObj.fromDateTime withFormat:DateFormatDigitYearMonthDay];
    booking1.bookingTime = [NSDate stringFromDate:reservationObj.fromDateTime withFormat:DateFormatDigitHourMinute];
    booking1.bookingDescription = reservationObj.note;
    
    booking1.reservation = reservationObj;
    
    [self performSegueWithIdentifier:kCartSegue sender:booking1];
    
    //TODO: persist booking to Cart cache
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
        vc.passedBooking = (Booking *)sender;
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
