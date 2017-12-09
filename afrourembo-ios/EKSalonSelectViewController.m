//
//  EKSalonSelectViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonSelectViewController.h"

static NSString * const kSalonSelectCell = @"salonSelectCell";
static NSString * const kServiceSegue = @"salonSelectToServiceVC";
static NSString * const kUnwindSegue  = @"unwindFromSalonListToBPSettingsVC";

@implementation EKSalonSelectViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select your salon";
    
    _dataSourceArray = [NSMutableArray new];
    
    [Explore getSalonsForCategory:nil
                       andService:nil
                        WithBlock:^(NSArray<Salon *> *salonArray) {
                            
                            [_dataSourceArray addObjectsFromArray:salonArray];
                            [self.tableView reloadData];
                            
                        } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                            
                            [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                        }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalonSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSalonSelectCell forIndexPath:indexPath];

    Salon *salonObj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    cell.cellTextLabel.text = salonObj.name;
    
    if (salonObj.isCentralizedModel) {
    
        cell.cellImageView.image = [UIImage imageNamed:@"icCentered"];
    
    } else {
        
        cell.cellImageView.image = [UIImage imageNamed:@"icDecentrilized"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Salon *salonObj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Professional joinSalon:salonObj.salonID
                  withToken:self.passedProfessional.token
                  withBlock:^(Salon *salonObj) {
    
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      
                      if (self.unwindSegue && self.unwindSegue.length > 0) {
                          [self performSegueWithIdentifier:kUnwindSegue sender:nil];
                      } else {
                          [self performSegueWithIdentifier:kServiceSegue sender:nil];
                      }

                  } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                     
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                 }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([segue.identifier isEqualToString:kServiceSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;
    }
}

@end
