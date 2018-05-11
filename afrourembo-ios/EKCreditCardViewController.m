//
//  EKCreditCardViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKCreditCardViewController.h"

static NSString * const kDatePickerSegue = @"creditCardToDatePickerVC";

@implementation EKCreditCardViewController {
    UITextField *_activeTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.cellTitleLabel.text = @"Card number";
            cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.cellTextField.placeholder = @"0000000000000000";
            cell.cellTextField.text = self._cardNumber;
            cell.cellTextField.tag = 0;
            [self addKeyboadToolbarTo:cell.cellTextField];
            break;
            
        case 1:
            cell.cellTitleLabel.text = @"MM/YY";
            cell.cellTextField.placeholder = @"MM/YY";
            cell.cellTextField.text = self._MMYY;
            cell.cellTextField.tag = 1;
            [self addKeyboadToolbarTo:cell.cellTextField];
            
            break;
        
        case 2:
            cell.cellTitleLabel.text = @"Full name";
            cell.cellTextField.placeholder = @"First name Last name";
            cell.cellTextField.text = self._fullName;
            cell.cellTextField.tag = 2;
            [self addKeyboadToolbarTo:cell.cellTextField];
            break;
            
        case 3:
            cell.cellTitleLabel.text = @"CVV";
            cell.cellTextField.placeholder = @"000";
            cell.cellTextField.text = self._CVV;
            cell.cellTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.cellTextField.tag = 3;
            [self addKeyboadToolbarTo:cell.cellTextField];
            break;
    
        default: break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
}

#pragma mark - UITextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _activeTextField = textField;
    
    if (textField.tag == 1) {
        [textField resignFirstResponder];
        [self performSegueWithIdentifier:kDatePickerSegue sender:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Prevent crashing undo bug
    if (range.length + range.location > textField.text.length) {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    switch (textField.tag) {
            
        case 0: // Card number
            self._cardNumber = textField.text;
            return newLength <= 19;
            break;
            
        case 1: // MM/YY
            self._MMYY = textField.text;
            return newLength <= 5;
            break;
            
        case 2: // Full name
            self._fullName = textField.text;
            return YES;
            break;
            
        case 3: // CVV
            self._CVV = textField.text;
            return newLength <= 3;
            break;
            
        default: return YES; break;
    }
}

#pragma mark - EKDatePickerDelegate

- (void)didPickDate:(NSDate *)date {
    
    self._MMYY = [NSDate stringFromDate:date withFormat:DateFormatDigitMonthDashYear];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)addKeyboadToolbarTo:(UITextField *)textField {
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(diTapToolbarDoneButton) ];
    
    
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    textField.inputAccessoryView = keyboardToolbar;
}

- (IBAction)diTapToolbarDoneButton {
    
    if (_activeTextField && _activeTextField.isFirstResponder) {
        [_activeTextField resignFirstResponder];
    }
}

- (IBAction)unwindToCreditCardVC:(UIStoryboardSegue *)segue { }

#pragma mark - Helpers

- (BOOL)validateData {

//    Map<String, String> params = new HashMap<>();
//    params.put("Mobicard_Version", "1.0");
//    params.put("Mobicard_Mode", "SILENT-HOSTED");
//    params.put("Mobicard_Order_Amount", String.valueOf((int) cartInfo.getAmount() * 100)); //amount should be sent in cents
//    params.put("Mobicard_Order_Currency", cartInfo.getCurrency()); //KES
//    params.put("Mobicard_Item_Description", cartInfo.getDescription()); //shou maken - service+pro+client
//    params.put("Mobicard_Transaction_Reference", bookingId); //
//    params.put("Mobicard_MerchantID", BuildConfig.PAYMENT_GATEWAY_MERCHANT_ID);
//    params.put("Mobicard_API_Key", BuildConfig.PAYMENT_GATEWAY_API_KEY);
//    params.put("Mobicard_First_Name", firstName);
//    params.put("Mobicard_Last_Name", lastName);
//    params.put("Mobicard_Address", address);
//    params.put("Mobicard_Postal_Code", postal); //has to be <= 20 chars
//    params.put("Mobicard_Country_Code", countryStr); //LB
//    params.put("Mobicard_Mobile_Number", phone);
//    params.put("Mobicard_Email", mLocalDataStore.getUser().getEmail()); //user.email
//    params.put("Mobicard_Payment_Type", "CARD");
//    params.put("Mobicard_Payment_Set", "1");
    
//    params.put("Mobicard_Cnumber", creditcardNumber); //42s
//    params.put("Mobicard_Cvv", creditcardCvvNumber); //100
//    params.put("Mobicard_Cexp_Month", creditcardMonthExpiry); //02
//    params.put("Mobicard_Cexp_Year", creditcardYearExpiry); //2019
//    
//    JSONObject jsonObject = new JSONObject(params);
//    mView.startCreditCardPayment(jsonObject);

    
    
//    _cardNumber;
//    _MMYY;
//    _fullName;
//    _CVV;
    
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kDatePickerSegue]) {
        EKDatePickerViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

@end
