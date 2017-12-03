//
//  EKBookingViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController.h"

static NSString * const kCartSegue   = @"bookingTimeToCartVC";

//static NSString * const kPlaceHolderText = @"What do you like about this place?";
static CGFloat const kContainerViewHeight = 100;

@implementation EKBookingViewController {
    BOOL _keyboardShowing;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // init data source
    self.daysDataSource     = [NSMutableArray new];
    self.timesDataSource    = [NSMutableArray new];
    self.selectedFromDate   = nil;
    self.selectedToDate     = nil;
    self.bookingNote        = @"";
    self.selectedPro        = nil;
    
//    self.containerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kContainerViewHeight);
//    [self.view addSubview:self.containerView];
//    self.containerView.hidden = YES;
    
    self.emptyTimeDataView.frame = CGRectMake(self.timeCollectionView.frame.origin.x, self.timeCollectionView.frame.origin.y,
                                              self.timeCollectionView.frame.size.width, self.timeCollectionView.frame.size.height);
    self.emptyTimeDataView.hidden = NO;
    [self.view addSubview:self.emptyTimeDataView];
}

/*
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
 */

#pragma mark - UITextViewDelegate

/*
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
*/

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

#pragma mark - Actions

- (IBAction)didTapNextButton:(UIBarButtonItem *)sender {
    
    if (_selectedPro) {
        
        Reservation *reservationObj = [Reservation new];
        reservationObj.actorId      = _selectedPro.professionalID;
        reservationObj.serviceId    = self.passedService.serverServiceId;
        reservationObj.fromDateTime = self.selectedFromDate;
        reservationObj.toDateTime   = self.selectedToDate;
        reservationObj.salonId      = self.salonId;
        reservationObj.salonName    = self.salonName;
        reservationObj.type = kProfessionalType;
        reservationObj.note = self.bookingNote;
        
        Booking *booking1 = [Booking new];
        
        booking1.reservation = reservationObj;
        
        booking1.bookingTitle   = self.passedService.serviceName;
        booking1.bookingCost    = [NSString stringWithFormat:@"%ld %@", (long)self.passedService.price, self.passedService.currency];
        booking1.bookingVendor  = [NSString stringWithFormat:@"%@ %@", self.selectedPro.fName, self.selectedPro.lName]; //TODO: or salon name
        booking1.practionner    = [NSString stringWithFormat:@"%@ %@", self.selectedPro.fName, self.selectedPro.lName];
        booking1.bookingDate    = reservationObj.fromDateTime;
        booking1.bookingDescription = reservationObj.note;
        
        booking1.bookingOwner   = [EKSettings getSavedCustomer].email;
        booking1.bookingHash    = [Booking hashBooking:booking1];
        
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] addOrUpdateObject:booking1];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        
        [self performSegueWithIdentifier:kCartSegue sender:nil];
    
    } else {
    
        [self showMessage:@"Select a professional and a time slot before proceeding" withTitle:@"Error" completionBlock:nil];
    }
}

- (IBAction)didTapAddNoteButton:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add a note"
                                                                   message:@"Add a note for this booking below"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Note ...";

        if (self.bookingNote.length > 0) {
            textField.text = self.bookingNote;
        }
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                if (alert.textFields.count > 0) {
                                                    
                                                    UITextField *emailTextField = [alert.textFields firstObject];
                                                    self.bookingNote = emailTextField.text;
                                                }
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//- (IBAction)didTapDoneButton:(id)sender {
//    
//    [self.textView resignFirstResponder];
//    self.containerView.hidden = YES;
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kCartSegue]) {
//        EKCartViewController *vc = segue.destinationViewController;
//        vc.passedBooking = (Booking *)sender;
    }
}

#pragma mark - Helpers

/*
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
*/

@end
