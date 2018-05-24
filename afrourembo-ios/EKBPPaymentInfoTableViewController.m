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
    
    [Bank getBanksListWithBlock:^(NSArray *array) {

        _banksArray = [NSArray arrayWithArray:array];
        
    } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
        
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
        [self performSegueWithIdentifier:kBankPickerSegue sender:nil];
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
}

#pragma mark - Actions

- (IBAction)unwindToBPPaymentInfoVC:(UIStoryboardSegue *)segue {}

- (IBAction)didTapSave:(UIButton *)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Bank postPaymentInfoForProfessional:self.passedProfessional.token
                                    bank:_bankID
                               firstName:self.firstNameTextField.text
                                lastName:self.lastNameTextField.text
                            acountNumber:self.accountNumberTextField.text
                               withBlock:^(Professional *professional) {
                                 
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self performSegueWithIdentifier:kAddServiceSegue sender:professional];
                                   
                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
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

@end
