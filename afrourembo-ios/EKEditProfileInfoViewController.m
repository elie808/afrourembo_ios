//
//  EKEditProfileInfoViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/24/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKEditProfileInfoViewController.h"

static int const kMaxImageSize = 0.3; //MBs

static NSString * const keditProfileInfoCell = @"editProfileInfoCell";
static NSString * const kExploreSegue = @"editVcToExploreVC";

@interface EKEditProfileInfoViewController () {
    NSArray *_dataSourceArray;
} @end

@implementation EKEditProfileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile information";
    
//    if (self.passedUser.profilePicture.length > 0) {
//        
//        [self.profilePicImageView yy_setImageWithURL:[NSURL URLWithString:self.passedUser.profilePicture]
//                                             options:YYWebImageOptionProgressiveBlur];
//    }
    
    _dataSourceArray = @[
                         @{@"First name" : self.passedUser.fName.length > 0 ? self.passedUser.fName : @"Your name"},
                         @{@"Last name" : self.passedUser.lName.length > 0 ? self.passedUser.lName : @"Your last name"},
                         @{@"Phone number" : self.passedUser.phone.length > 0 ? self.passedUser.phone : @"(___) ___ - ___"}
                         ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:keditProfileInfoCell forIndexPath:indexPath];
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTitleLabel.text = labelValue;
    
    if (indexPath.row == 0 && self.passedUser.fName.length > 0) {
        cell.cellTextField.text = placeHolderValue;
    } else {
        cell.cellTextField.placeholder = placeHolderValue;
    }
    
    if (indexPath.row == 1 && self.passedUser.lName.length > 0) {
        cell.cellTextField.text = placeHolderValue;
    } else {
        cell.cellTextField.placeholder = placeHolderValue;
    }
    
    if (indexPath.row == 2 && self.passedUser.phone.length > 0) {
        cell.cellTextField.text = placeHolderValue;
    } else {
        cell.cellTextField.placeholder = placeHolderValue;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ProfilePicture uploadCustomerProfilePicture:[UIImage compressImage:image toSize:kMaxImageSize]
                                       withToken:self.passedUser.token
                                       withBlock:^(Customer *customer) {
                                           
                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           self.profilePicImageView.image = image;
                                       }
                                      withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                          
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                      }];
}

#pragma mark - Actions

- (IBAction)didTapChageProfilePicture:(id)sender {
    
    [self presentAlertController];
}

- (IBAction)didTapSubmitButton:(id)sender {

    EKTextFieldTableViewCell *fNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *lNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EKTextFieldTableViewCell *phoneCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSString *fNameStr  = fNameCell.cellTextField.text;
    NSString *lNameStr   = lNameCell.cellTextField.text;
    NSString *phoneStr   = phoneCell.cellTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Customer updateCustomerProfile:fNameStr
                           lastName:lNameStr
                              phone:phoneStr
                            forUser:self.passedUser.token
                          withBlock:^(Customer *customerObj) {
                     
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                              [EKSettings updateSavedCustomer:customerObj];

                              if (self.unwindToExploreVC) {
                              
                                  [self.navigationController popViewControllerAnimated:YES];
                              
                              } else {
                               
                                  [self showMessage:@"You have succesfully created your AfroUrembo account!"
                                          withTitle:@"Success"
                                    completionBlock:^(UIAlertAction *action) {
                                        [self performSegueWithIdentifier:kExploreSegue sender:nil];
                                    }];
                              }
                    } withErrors:^(NSError *error, NSString *errorMessage) {
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [self showMessage:errorMessage withTitle:@"There is something wrong" completionBlock:nil];
                   }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kExploreSegue]) {
        
    }
}

#pragma mark - Helpers

- (void)presentAlertController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Upload your profile picture"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *myLocationsAction = [UIAlertAction actionWithTitle:@"from Photo Gallery"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [self openPhotoGallery];
                                                              }];
    
    UIAlertAction *friendsLocationsAction = [UIAlertAction actionWithTitle:@"from Camera"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action) {
                                                                       [self openCamera];
                                                                   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    
    [alertController addAction:myLocationsAction];
    [alertController addAction:friendsLocationsAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)openPhotoGallery {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)openCamera {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraDevice=UIImagePickerControllerCameraDeviceFront;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

@end
