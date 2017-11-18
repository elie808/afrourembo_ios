//
//  EKEditProfileBPViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 11/17/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKEditProfileBPViewController.h"

static int const kMaxImageSize = 0.3; //MBs
static NSString * const kSignUpCell = @"editBPProfileCell";
static NSString * const kUnwindSegue = @"unwindEditProfileToSettingsVC";

@interface EKEditProfileBPViewController () {
    NSArray *_dataSourceArray;
} @end

@implementation EKEditProfileBPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Edit profile";

    _dataSourceArray = [NSMutableArray new];
    
    //TODO: Add support for SALON
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Professional getProfileForProfessional:[EKSettings getSavedVendor].token
                                  withBlock:^(Professional *professionalObj) {
                                     
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      _dataSourceArray = @[
                                                           @{@"First name" : professionalObj.fName},
                                                           @{@"Last name" : professionalObj.lName},
                                                           @{@"Phone number" : professionalObj.phone},
                                                           @{@"About" : professionalObj.about}
                                                           ];
                                      
                                      [self.profilePicImageView yy_setImageWithURL:[NSURL URLWithString:professionalObj.profilePicture]
                                                                           options:YYWebImageOptionProgressiveBlur];
                                      
                                      [self.tableView reloadData];
                                      
                                  } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSignUpCell forIndexPath:indexPath];
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *textValue  = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.text = textValue;
    
    if (indexPath.row == 2) { // phone number cell
        cell.cellTextField.keyboardType = UIKeyboardTypePhonePad;
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

#pragma mark - Actions

- (IBAction)didTapUpdateProfileButton:(id)sender {
    
    EKTextFieldTableViewCell *fNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *lNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EKTextFieldTableViewCell *phoneCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    EKTextFieldTableViewCell *aboutCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    NSString *fNameStr = fNameCell.cellTextField.text;
    NSString *lNameStr = lNameCell.cellTextField.text;
    NSString *phoneStr = phoneCell.cellTextField.text;
    NSString *aboutStr = aboutCell.cellTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Professional udpateProfile:fNameStr
                       lastName:lNameStr
                    phoneNumber:phoneStr
                          about:aboutStr
                      withToken:[EKSettings getSavedVendor].token
                      withBlock:^(Professional *professionalObj) {
    
                          [EKSettings updateSavedProfessional:professionalObj];
                          
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          
                          [self performSegueWithIdentifier:kUnwindSegue sender:nil];
                          
                      } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                          
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          [self showMessage:errorMessage
                                  withTitle:@"There is something wrong"
                            completionBlock:nil];
                      }];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
       
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfilePicture uploadProfessionalProfilePicture:[UIImage compressImage:self.profilePicImageView.image toSize:kMaxImageSize]
                                               withToken:[EKSettings getSavedVendor].token
                                               withBlock:^(Professional *professional) {
                                                   
                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                   [self.profilePicImageView
                                                    yy_setImageWithURL:[NSURL URLWithString:professional.profilePicture]
                                                    options:YYWebImageOptionProgressiveBlur];
                                                   
                                               } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                   [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                               }];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

#pragma mark - Actions

- (IBAction)didTapChageProfilePicture:(id)sender {
    
    [self presentAlertController];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
