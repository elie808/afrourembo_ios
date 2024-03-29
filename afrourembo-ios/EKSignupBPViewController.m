//
//  EKSignupBPViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSignupBPViewController.h"

static int const kMaxImageSize = 0.3; //MBs

static NSString * const kSignUpCell = @"signUpBPCell";

static NSString * const kRoleSegue = @"signupBPToRoleVC";
static NSString * const kSalonInfoSegue = @"signUpToSalonInfoVC";

@interface EKSignupBPViewController () {
    NSArray *_dataSourceArray;
    BOOL _didPickProfilePicture;
} @end

@implementation EKSignupBPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign up";
    
    _didPickProfilePicture = NO;
    
    _dataSourceArray = @[
                         @{@"First name" : @"Your name"},
                         @{@"Last name" : @"Your last name"},
                         @{@"Email" : @"address@mail.com"},
                         @{@"Password" : @"Your password"},
                         @{@"Phone number" : @"phone number"}
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
    
    EKTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSignUpCell forIndexPath:indexPath];
    
    NSString *labelValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allKeys] firstObject];
    NSString *placeHolderValue = [[(NSDictionary *)[_dataSourceArray objectAtIndex:indexPath.row] allValues] firstObject];
    
    cell.cellTitleLabel.text = labelValue;
    cell.cellTextField.placeholder = placeHolderValue;
    
    if (indexPath.row == 2) {
        cell.cellTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    
    if (indexPath.row == 4) {
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

- (IBAction)didTapSignUpButton:(id)sender {
    
    EKTextFieldTableViewCell *fNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EKTextFieldTableViewCell *lNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EKTextFieldTableViewCell *emailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    EKTextFieldTableViewCell *passCell  = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    EKTextFieldTableViewCell *phoneCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    NSString *fNameStr = fNameCell.cellTextField.text;
    NSString *lNameStr = lNameCell.cellTextField.text;
    NSString *emailStr = [emailCell.cellTextField.text lowercaseString];
    NSString *passStr  = passCell.cellTextField.text;
    NSString *phoneStr = phoneCell.cellTextField.text;
    
    if (self.signUpRole == SignUpRoleBP) {
     
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Professional signUpProfessional:emailStr password:passStr firstName:fNameStr lastName:lNameStr phoneNumber:phoneStr
                               withBlock:^(Professional *professionalObj) {
                                   
                                   NSLog(@"PROFESSIONAL SIGNED UP!!");
                                   [EKSettings saveVendor:professionalObj];
                                   
                                   // can't place this call outside, because we depend on token, which is innexistent outside...0 sense.
                                   if (_didPickProfilePicture) {
                                       
                                       [ProfilePicture
                                        uploadProfessionalProfilePicture:[UIImage compressImage:self.profilePicImageView.image
                                                                                         toSize:kMaxImageSize]
                                        withToken:professionalObj.token
                                        withBlock:^(Professional *professional) {
                                            
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                            // self.profilePicImageView.image = image;
                                            [self performSegueWithIdentifier:kRoleSegue sender:professionalObj];
                                        }
                                        withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                            
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                            [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                        }];
                                   }
                                   
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self performSegueWithIdentifier:kRoleSegue sender:professionalObj];
                               }
                              withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                  
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  [self showMessage:errorMessage withTitle:@"There is something wrong" completionBlock:nil];
                              }];
        
    } else if (self.signUpRole == SignUpRoleSalon) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Salon signUpSalon:emailStr password:passStr firstName:fNameStr lastName:lNameStr phoneNumber:phoneStr
                 withBlock:^(Salon *salonObj) {
                     
                     NSLog(@"SALON SIGNED UP!!");
                     [EKSettings saveSalon:salonObj];
                     
                     // can't place this call outside, because we depend on token, which is innexistent outside...0 sense.
                     if (_didPickProfilePicture) {
                     }
                     
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [self performSegueWithIdentifier:kSalonInfoSegue sender:salonObj];
                     
                 } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                    
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [self showMessage:errorMessage withTitle:@"There is something wrong" completionBlock:nil];
                }];
    }
}

- (IBAction)didTapFacebookSignUpButton:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [login logOut];
        
    } else {
        
        // Login using Facebook account
        [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                     fromViewController:self
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    
                                    if (!error && !result.isCancelled ) {

                                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                        
                                        if (self.signUpRole == SignUpRoleBP) {
                                         
                                            [ProfessionalLogin
                                             signUpProfessionalWithFacebook:result.token.tokenString
                                             withBlock:^(Professional *professionalObj) {
                                                 
                                                 NSLog(@"PROF SIGNED UP!!");
                                                 
                                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 
                                                 [EKSettings saveVendor:professionalObj];
                                                 
                                                 [self performSegueWithIdentifier:kRoleSegue sender:professionalObj];
                                                 
                                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                 
                                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 [self showMessage:errorMessage withTitle:@"There is something wrong" completionBlock:nil];
                                             }];
                                            
                                        } else if (self.signUpRole == SignUpRoleSalon) {
                                            
                                            [SalonLogin
                                             signUpSalonWithFacebook:result.token.tokenString
                                             withBlock:^(Salon *salonObj) {
                                                 
                                                 NSLog(@"SALON SIGNED UP!!");
                                                 
                                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 
                                                 [EKSettings saveSalon:salonObj];
                                                 
                                                 [self performSegueWithIdentifier:kSalonInfoSegue sender:salonObj];
                                                 
                                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                 
                                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 [self showMessage:errorMessage withTitle:@"There is something wrong" completionBlock:nil];
                                             }];
                                        }
                                    }
                                }];
    }
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.profilePicImageView.image = image;
    _didPickProfilePicture = YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kRoleSegue]) {
        
        EKRoleViewController *vc = segue.destinationViewController;
        Professional *profObj = (Professional *)sender;
        vc.passedProfessional = profObj;
    }
    
    if ([segue.identifier isEqualToString:kSalonInfoSegue]) {
        EKSalonInfoViewController *vc = segue.destinationViewController;
        Salon *salonObj = (Salon *)sender;
        vc.passedSalon = salonObj;
    }
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


@end
