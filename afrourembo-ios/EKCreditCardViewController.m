//
//  EKCreditCardViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKCreditCardViewController.h"

@interface EKCreditCardViewController ()

@end

@implementation EKCreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Card number
    // MM/YY
    // Full name
    // CVV
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
            cell.cellTextField.placeholder = @"placeholder";
            break;
            
        case 1:
            cell.cellTitleLabel.text = @"MM/YY";
            cell.cellTextField.placeholder = @"placeholder";
            break;
        
        case 2:
            cell.cellTitleLabel.text = @"Full name";
            cell.cellTextField.placeholder = @"placeholder";
            break;
            
        case 3:
            cell.cellTitleLabel.text = @"CVV";
            cell.cellTextField.placeholder = @"placeholder";
            break;
    
        default: break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
