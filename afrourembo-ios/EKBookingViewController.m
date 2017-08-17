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

static NSString * const kCartSegue   = @"bookingTimeToCartVC";
static NSString * const kSignUpSegue = @"bookingVCToSignUpVC";

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
    
    Professional *_selectedPro;
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
    _selectedPro        = nil;
    
    self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kContainerViewHeight);
    [self.view addSubview:self.containerView];
    self.containerView.hidden = YES;
    //    self.textView.text = kPlaceHolderText;
    
    self.emptyTimeDataView.frame = CGRectMake(self.timeCollectionView.frame.origin.x, self.timeCollectionView.frame.origin.y,
                                              self.timeCollectionView.frame.size.width, self.timeCollectionView.frame.size.height);
    self.emptyTimeDataView.hidden = NO;
    [self.view addSubview:self.emptyTimeDataView];
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
        
        Day *day = _daysDataSource[indexPath.row];
        
        cell.cellDayLabel.text = day.dayName;
        
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

- (void)showLoginSignUpDialog {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You are not signed in"
                                                                   message:@"Sign in or create a new account"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"email";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"password";
    }];
    
    UIAlertAction *signInAction = [UIAlertAction actionWithTitle:@"Sign in" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {

                                                             if (alert.textFields.count > 0) {
                                                           
                                                           
                                                                 UITextField *emailTextField = [alert.textFields firstObject];
                                                                 UITextField *passwordTextField = [alert.textFields objectAtIndex:1];

                                                                 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                                                 [Customer loginCustomer:emailTextField.text
                                                                                password:passwordTextField.text
                                                                               withBlock:^(Customer *customerObj) {
                                                                                   
                                                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                                   [EKSettings saveCustomer:customerObj];
                                                                               }
                                                                              withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                                                  
                                                                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                                  [self showMessage:errorMessage
                                                                                          withTitle:@"There is something wrong"
                                                                                    completionBlock:nil];
                                                                              }];
                                                       }
                                                   }];
    
    [alert addAction:signInAction];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Sign up" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                [EKSettings deleteBookingsForCustomer:[EKSettings getSavedCustomer]];
                                                [EKSettings deleteSavedCustomer];
                                                [self performSegueWithIdentifier:kSignUpSegue sender:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    if (collectionView == self.proCollectionView) {
     
        Professional *pro = self.professionalsDataSource[indexPath.row];

        _selectedPro = pro;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Day getAvailabilityOfVendor:pro.professionalID
                              ofType:_vendorType
                           withToken:[EKSettings getSavedCustomer].token
                           withBlock:^(NSArray *daysArray) {
                               
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               
                                self.emptyTimeDataView.hidden = YES;
                               
                               [self populateDataSourcesFrom:daysArray];
  
                               [self.dayCollectionView reloadData];
//                                [self.timeCollectionView reloadData];
                           }
                          withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                              
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              
                              if (statusCode == 401) { //invalid token
                                  [self showLoginSignUpDialog];
                              } else {
                                  [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }
                              
                              self.emptyTimeDataView.hidden = NO;
                          }];
    }
    
    if (collectionView == self.dayCollectionView) {
        
        Day *day = _daysDataSource[indexPath.row];
        
        [_timesDataSource removeAllObjects];
        [_timesDataSource addObjectsFromArray:day.timeSlotsArray];
        
        [self.timeCollectionView reloadData];
    }
    
    if (collectionView == self.timeCollectionView) {

        TimeSlot *timeSlot = _timesDataSource[indexPath.row];
        
        // compute how many time slots ahead to highlight
        int timeSlotsAhead = self.passedService.time / 15;
        
        if (timeSlot.isAvailable && (indexPath.row + timeSlotsAhead) < _timesDataSource.count) {

            // check if slots to be selected, don't overlap with unavailable slots
            BOOL allSlotsAheadAvailable = YES;
            for (int i = 0; i <= timeSlotsAhead; i++) {
                
                TimeSlot *nextSlot = _timesDataSource[indexPath.row+i];
                if (!nextSlot.isAvailable) {
                    allSlotsAheadAvailable = NO;
                    i = timeSlotsAhead;
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
                
                for (int i = 0; i <= timeSlotsAhead; i++) {
                    TimeSlot *nextSlot = _timesDataSource[indexPath.row+i];
                    nextSlot.isSelected = YES;
                }
                
                _selectedFromDate   = ((TimeSlot *)(_timesDataSource[indexPath.row])).date;
                _selectedToDate     = ((TimeSlot *)(_timesDataSource[indexPath.row + timeSlotsAhead])).date;
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
    
    //TODO: check if user is signed in ???
    if (_selectedPro) {
        
        Reservation *reservationObj = [Reservation new];
        reservationObj.actorId      = _selectedPro.professionalID;
        reservationObj.serviceId    = self.passedService.serverServiceId;
        reservationObj.fromDateTime = _selectedFromDate;
        reservationObj.toDateTime   = _selectedToDate;
        reservationObj.type = _vendorType;
        reservationObj.note = _bookingNote;
        
        Booking *booking1 = [Booking new];
        
        booking1.reservation = reservationObj;
        
        booking1.bookingTitle   = self.passedService.serviceName;
        booking1.bookingCost    = [NSString stringWithFormat:@"%.0f %@", self.passedService.price, self.passedService.currency];
        booking1.bookingVendor  = [NSString stringWithFormat:@"%@ %@", _selectedPro.fName, _selectedPro.lName]; //TODO: or salon name
        booking1.practionner    = [NSString stringWithFormat:@"%@ %@", _selectedPro.fName, _selectedPro.lName];
        booking1.bookingDate    = reservationObj.fromDateTime;
        booking1.bookingDescription = reservationObj.note;
        
        booking1.bookingOwner   = [EKSettings getSavedCustomer].email;
        booking1.bookingHash    = [NSString stringWithFormat:@"%@%@%@%@", booking1.bookingOwner, booking1.reservation.serviceId, booking1.reservation.actorId, booking1.bookingDate ];
        
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] addOrUpdateObject:booking1];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        
        [self performSegueWithIdentifier:kCartSegue sender:nil];
    
    } else {
    
        [self showMessage:@"Select a professional and a time slot before proceeding" withTitle:@"Error" completionBlock:nil];
    }
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
        
//        EKCartViewController *vc = segue.destinationViewController;
//        vc.passedBooking = (Booking *)sender;
    }
}

#pragma mark - Helpers

- (void)populateDataSourcesFrom:(NSArray<Day*> *)daysArray {

    // get all day numbers from daysArray
    // generate days
    
    for (Day *day in daysArray) {
    
        day.dayName = @"Day name";
        day.timeSlotsArray = [NSArray arrayWithArray:[self populateDayWithTimes:day.fromHours
                                                                     endingHour:day.toHours
                                                            lunchBreakStartHour:day.lbFromHours
                                                              lunchBreakEndHour:day.lbToHours
                                                             inMinuteIncrements:@15] ];
        
        [_daysDataSource addObject:day];
    }
}

- (void)populateDays {
    
    for (int i = 0; i < 10; i++) {
        
        [_daysDataSource addObject:[NSDate stringFromDate:[NSDate addDays:i after:[NSDate todayDate]]
                                               withFormat:DateFormatLetterDayMonthYear]];
    }
}

- (NSArray *)populateDayWithTimes:(NSNumber *)startHour endingHour:(NSNumber *)toHour lunchBreakStartHour:(NSNumber *)lbFromHour lunchBreakEndHour:(NSNumber *)lbToHour inMinuteIncrements:(NSNumber *)minIncrements {
    
    NSMutableArray *timeSlotsArray = [NSMutableArray new];
    BOOL isAvailable;
    
    for (int hour = [startHour intValue]; hour < [toHour intValue]; hour++) {
        
        for (int startingMin = 0; startingMin < 60; startingMin += [minIncrements intValue]) {
            
            // lunch break hours
            if ( hour > 13 && hour < 15 ) { isAvailable = NO; } else { isAvailable = YES; }
            
            TimeSlot *slot = [[TimeSlot alloc] initWithDate:[NSDate todayAtTime:[NSNumber numberWithInt:hour]
                                                                        minutes:[NSNumber numberWithInt:startingMin]]
                                            andAvailability:isAvailable];
            
            [timeSlotsArray addObject:slot];
        }
    }
    
    return [NSArray arrayWithArray:timeSlotsArray];
}

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
