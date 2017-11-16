//
//  EKAddServiceViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/1/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKAddServiceViewController.h"

static NSString * const kEditServiceSegue = @"serviceListToEditService";
static NSString * const kNewServiceSegue  = @"serviceListToNewService";
static NSString * const kAvailabilitySegue = @"addServiceToAvailabilityVC";

static NSString * const kServiceCell = @"addServiceCell";

static NSString * const kUnwindFromNewService = @"unwindFromNewServiceToServiceVC";
static NSString * const kUnwindToSettings = @"unwindAddServicesToBPSettings";

@implementation EKAddServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Services";
    
    self.dataSourceArray = [NSMutableArray new];
    
    // if viewcontroller is accessed from professional's Settings. Could potentially use the unwindSegueID property for extra ghettoness
    if ([EKSettings getSavedVendor].token.length > 0) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Professional getProfileForProfessional:[EKSettings getSavedVendor].token
                                      withBlock:^(Professional *professionalObj) {
        
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          
                                          [self.dataSourceArray addObjectsFromArray:professionalObj.services];
                                          
                                          [self.tableView reloadData];
                                          
                                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                      }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKAccessoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServiceCell forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    
    Service *serviceObj = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    // ghetto workaround to handle all nil serviceName proprety when adding a new Service...who needs fucking consistency anyway ?!?!?
    if (serviceObj.serviceName.length > 0) {
        cell.cellTextLabel.text = serviceObj.serviceName;
    } else {
        cell.cellTextLabel.text = serviceObj.name;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - EKAccessoryCellDelegate

- (void)didTapAccessoryButtonAtIndex:(NSIndexPath *)indexPath {
    
    Service *serviceObj = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:kEditServiceSegue sender:serviceObj];
}

#pragma mark - Actions

- (IBAction)didTapAddServiceButton:(id)sender {
    
    [self performSegueWithIdentifier:kNewServiceSegue sender:nil];
}

- (IBAction)didTapNextButton:(id)sender {
    
    if (self.dataSourceArray.count > 0) {
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        for (int i = 0; i < self.dataSourceArray.count; i++) {
     
            Service *serviceObj = [self.dataSourceArray objectAtIndex:i];
            
            [Service postServiceForVendor:self.passedProfessional.token
                              forCategory:serviceObj.categoryId
                                  service:serviceObj.serviceId
                                    price:serviceObj.price
                                     time:serviceObj.time
                                withBlock:^(Service *servicenObj) {
                                    
                                    if (i == self.dataSourceArray.count-1) {
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        
                                        if (self.unwindSegueID && self.unwindSegueID.length > 0) {
                                            [self performSegueWithIdentifier:kUnwindToSettings sender:nil];
                                        } else {
                                            [self performSegueWithIdentifier:kAvailabilitySegue sender:nil];
                                        }
                                    }
                                }
                               withErrors:^(NSError *error, NSString *errorMessage, NSNumber *statusCode) {
                                   
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   
                                   //TODO: REMOVE THIS GHETTO ASS FIX, AND ALWAYS DISPLAY ERRORS !!
                                   if (self.unwindSegueID.length > 0) {
                                       //THIS IS ALSO BULLSHIT AND SHOULD BE REMOVED
                                       [self performSegueWithIdentifier:kUnwindToSettings sender:nil];
                                       
                                   } else {
                                   
                                       [self showMessage:errorMessage
                                               withTitle:@"There is something wrong"
                                         completionBlock:nil];
                                   }
                               }];
        }
    
    } else {
        
        if (self.unwindSegueID && self.unwindSegueID.length > 0) {
            [self performSegueWithIdentifier:kUnwindToSettings sender:nil];
        } else {
            [self performSegueWithIdentifier:kAvailabilitySegue sender:nil];
        }
    }
}

#pragma mark - Navigation

- (IBAction)unwindToAddServiceVC:(UIStoryboardSegue *)segue {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kNewServiceSegue]) {
        
    }
    
    if ([segue.identifier isEqualToString:kEditServiceSegue]) {
        
        EKAddNewServiceViewController *vc = segue.destinationViewController;
        vc.passedService = (Service*)sender;
    }
    
    if ([segue.identifier isEqualToString:kAvailabilitySegue]) {
        
        EKAvailabilityViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;
    }
}

@end
