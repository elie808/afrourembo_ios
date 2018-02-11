//
//  EKBookingViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/16/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKBookingViewController.h"
#import "EKBookingViewController+CollectionView.h"

static NSString * const kCartSegue   = @"bookingTimeToCartVC";

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
    
    self.emptyTimeDataView.frame = CGRectMake(self.timeCollectionView.frame.origin.x, self.timeCollectionView.frame.origin.y,
                                              self.timeCollectionView.frame.size.width, self.timeCollectionView.frame.size.height);
    self.emptyTimeDataView.hidden = NO;
    [self.view addSubview:self.emptyTimeDataView];
    
    
    if (self.professionalsDataSource.count == 1) {
        
        Professional *pro = [self.professionalsDataSource firstObject];
        
        [self.proCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES
                                       scrollPosition:UICollectionViewScrollPositionNone];
        [self getDaysForPro:pro];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setTwoLineTitle:self.passedService.serviceName
               secondLine:[NSString stringWithFormat:@"%ld %@ for %ld minutes", (long)self.passedService.price, self.passedService.currency, self.passedService.time]];
}

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
        reservationObj.note = self.bookingNote.length ? self.bookingNote : @"No notes";
        
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kCartSegue]) {
//        EKCartViewController *vc = segue.destinationViewController;
//        vc.passedBooking = (Booking *)sender;
    }
}

#pragma mark - Helpers

/// Show title on 2 lines in the navigation controller bar
- (void)setTwoLineTitle:(NSString *)firstLine secondLine:(NSString*)secondLine {
    
    CGFloat titleLabelWidth = [UIScreen mainScreen].bounds.size.width/1.8;
    
    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleLabelWidth, 44)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleLabelWidth, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 2;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;

    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@"%@ \n", firstLine]
                                              attributes:[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:16]
                                                                                     forKey:NSFontAttributeName]];
    
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]
                                              initWithString:secondLine
                                              attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12]
                                                                                     forKey:NSFontAttributeName]];
    
    // color some words off the title
    // [vAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:(NSMakeRange(0, 15))];
    
    [aAttrString appendAttributedString:vAttrString];
    
    label.attributedText = aAttrString;
    
    [wrapperView addSubview:label];
    
    self.navigationItem.titleView = wrapperView;
}

@end
