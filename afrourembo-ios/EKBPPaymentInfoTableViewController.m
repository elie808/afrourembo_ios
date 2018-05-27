//
//  EKBPPaymentInfoTableViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/16/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKBPPaymentInfoTableViewController.h"

@implementation EKBPPaymentInfoTableViewController {
    NSArray *_banksArray;
    NSString *_bankID;
}

static NSString * const kAddServiceSegue   = @"paymentInfoToAddServiceVC";
static NSString * const kBankPickerSegue   = @"bpPaymentToBankPickerVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.passedProfessional) {
        self.firstNameTextField.text = self.passedProfessional.fName;
        self.lastNameTextField.text = self.passedProfessional.lName;
    }
    
    // disable bar button if view accessed from Sign Up flow
    if (!self.unwindSegueID && self.unwindSegueID.length == 0) {
        self.cancelBarButton.enabled = NO;
        self.cancelBarButton.tintColor = [UIColor clearColor];
    } else {
        [self getBPPaymentInfo];
    }
    
    [Bank getBanksListWithBlock:^(NSArray *array) {

        _banksArray = [NSArray arrayWithArray:array];
        
    } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
        [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
//        if (self.allFieldsEditable) {
        if (_banksArray.count > 0) {
            [self performSegueWithIdentifier:kBankPickerSegue sender:nil];
        }
//        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return textField.resignFirstResponder;
}

#pragma mark - EKBankPickerDelegate

- (void)didPickBank:(Bank *)bank {
    _bankLabel.text = bank.name;
    _bankID = bank.bankID;
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)unwindToBPPaymentInfoVC:(UIStoryboardSegue *)segue {}

- (IBAction)didTapCancel:(UIBarButtonItem *)sender {

    if (self.unwindSegueID && self.unwindSegueID.length > 0) {
        [self performSegueWithIdentifier:self.unwindSegueID sender:nil];
    }
}

- (IBAction)didTapSave:(UIButton *)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Bank postPaymentInfoForProfessional:self.passedProfessional.token
                                    bank:_bankID
                               firstName:self.firstNameTextField.text
                                lastName:self.lastNameTextField.text
                            acountNumber:self.accountNumberTextField.text
                               withBlock:^(Professional *professional) {
                                 
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   
                                   if (self.unwindSegueID && self.unwindSegueID.length > 0) {
                                       [self performSegueWithIdentifier:self.unwindSegueID sender:nil];
                                   } else {
                                       [self performSegueWithIdentifier:kAddServiceSegue sender:professional];
                                   }
                                   
                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                              }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kBankPickerSegue]) {
        
        EKBankPickerViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        vc.dataSource = [NSArray arrayWithArray:_banksArray];
    }
    
    if ([segue.identifier isEqualToString:kAddServiceSegue]) {

        EKAddServiceViewController *vc = segue.destinationViewController;
        
        vc.passedProfessional = (Professional*)sender;
    }
}

#pragma mark - Helpers

- (void)getBPPaymentInfo {
    
    if ([EKSettings getSavedVendor]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Professional getProfileForProfessional:[EKSettings getSavedVendor].token
                                      withBlock:^(Professional *professionalObj) {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          
                                          self.firstNameTextField.text = professionalObj.fName;
                                          self.lastNameTextField.text = professionalObj.lName;
                                          
                                          if (professionalObj.paymentInfo.name.length > 0) {
                                              self.bankLabel.text = professionalObj.paymentInfo.name;
                                          }
                                          
                                          self.accountNumberTextField.text = professionalObj.paymentInfo.accountNumber;
                                          _bankID = professionalObj.paymentInfo.bankID;

                                          [self.tableView reloadData];
                                          
                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                      }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Salon getProfileForSalon:[EKSettings getSavedSalon].token
                        withBlock:^(Salon *salonObj) {
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.firstNameTextField.text = salonObj.fName;
                            self.lastNameTextField.text = salonObj.lName;
                            //                                          self.bankLabel.text
                            //                                          self.accountNumberTextField.text
                            [self.tableView reloadData];
                            
                        } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                        }];
    }
}

@end
