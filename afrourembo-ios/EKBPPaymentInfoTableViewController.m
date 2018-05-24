//
//  EKBPPaymentInfoTableViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/16/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKBPPaymentInfoTableViewController.h"

@implementation EKBPPaymentInfoTableViewController

static NSString * const kAddServiceSegue   = @"paymentInfoToAddServiceVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.passedProfessional) {
        self.firstNameTextField.text = self.passedProfessional.fName;
        self.lastNameTextField.text = self.passedProfessional.lName;
    }
    
    [Bank getBanksListWithBlock:^(NSArray *array) {
        
        NSLog(@"BANKS ARRAY: %@", array);
        
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
        
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return textField.resignFirstResponder;
}

#pragma mark - Actions

- (IBAction)didTapSave:(UIButton *)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Bank postPaymentInfoForProfessional:self.passedProfessional.token
                                    bank:@"l06xzh4x0d"
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
    
    if ([segue.identifier isEqualToString:kAddServiceSegue]) {

        EKAddServiceViewController *vc = segue.destinationViewController;
        
        vc.passedProfessional = (Professional*)sender;
    }
}

@end
