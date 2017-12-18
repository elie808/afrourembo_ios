//
//  EKVendorGalleryViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKVendorGalleryViewController.h"

static int const kMaxImageSize = 0.3; //MBs
static NSString * const kUnwind = @"unwindSegue";
static NSString * const kGalleryCell  = @"galleryCell";

@implementation EKVendorGalleryViewController {
    NSMutableArray *_dataSource;
    NSMutableArray *_picsToDeleteArray;
    Pictures *_selectedPic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y,
                                          self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.emptyDataView.hidden = NO;
    [self.view addSubview:self.emptyDataView];
    [self.view bringSubviewToFront:self.addPicturesButton]; // make the button float on top of the empty data view
    
    _selectedPic = nil;
    _picsToDeleteArray = [NSMutableArray new];
    
    if ([EKSettings getSavedVendor]) {
        
        _dataSource = [NSMutableArray arrayWithArray:[EKSettings getSavedVendor].portfolio];
        
    } else if ([EKSettings getSavedSalon]) {
        
        _dataSource = [NSMutableArray arrayWithArray:[EKSettings getSavedSalon].portfolio];
    }
    
    if (_dataSource.count > 0) {
        self.emptyDataView.hidden = YES;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Pictures *pic = [_dataSource objectAtIndex:indexPath.row];
    
    EKVendorGalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGalleryCell forIndexPath:indexPath];
    
    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:pic.picture]
                               placeholder:[UIImage imageNamed:@"icGalleryEmpty"]
                                   options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation
                                completion:nil];

    if ([pic.pictureID isEqualToString:_selectedPic.pictureID]) {
        cell.layer.borderWidth = 2;
        cell.layer.borderColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0].CGColor;
    } else {
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Pictures *pic = [_dataSource objectAtIndex:indexPath.row];
    
    if ([_selectedPic.pictureID isEqualToString:pic.pictureID]) {
        _selectedPic = nil;
    } else {
        _selectedPic = pic;
    }
    
    [self.collectionView reloadData];
    
    if (_selectedPic) {
        self.deleteButton.tintColor = [UIColor colorWithRed:255./255. green:86./255. blue:0./255. alpha:1.0];
        self.deleteButton.enabled = YES;
    } else {
        self.deleteButton.tintColor = [UIColor clearColor];
        self.deleteButton.enabled = NO;
    }
}

#pragma mark - Actions

- (IBAction)didTapDoneButton:(id)sender {
    
    [self performSegueWithIdentifier:kUnwind sender:nil];
}

- (IBAction)didTapAddPhotoPicture:(id)sender {
    
    [self presentAlertController];
}

- (IBAction)deletePictures:(id)sender {
   
    // batch delete
    /*
    if (_picsToDeleteArray && _picsToDeleteArray.count > 0) {
        for (Pictures *pic in _picsToDeleteArray) {
            [self deletePictureWithID:pic.pictureID];
        }
    }
     */
    
    if (_selectedPic) { [self deletePictureWithID:_selectedPic.pictureID]; }
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    if ([EKSettings getSavedVendor]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfilePicture uploadProfessionalPortfolioPicture:[UIImage compressImage:image toSize:kMaxImageSize]
                                                 withToken:[EKSettings getSavedVendor].token
                                                 withBlock:^(Professional *professional) {
                                                     
                                                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                     
                                                     [EKSettings updateSavedProfessional:professional];
                                                     
                                                     [_dataSource removeAllObjects];
                                                     [_dataSource addObjectsFromArray:[EKSettings getSavedVendor].portfolio];
                                                     [self.collectionView reloadData];
                                                     
                                                     if (_dataSource.count > 0) {
                                                         self.emptyDataView.hidden = YES;
                                                     } else {
                                                         self.emptyDataView.hidden = NO;
                                                     }
                                                     
                                                     self.doneButton.enabled = YES;
                                                     self.doneButton.tintColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
                                                     
                                                 } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                     [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                                 }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfilePicture uploadSalonPortfolioPicture:[UIImage compressImage:image toSize:kMaxImageSize]
                                          withToken:[EKSettings getSavedSalon].token
                                          withBlock:^(Salon *salon) {
                                              
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              
                                              [EKSettings updateSavedSalon:salon];
                                              
                                              [_dataSource removeAllObjects];
                                              [_dataSource addObjectsFromArray:[EKSettings getSavedSalon].portfolio];
                                              [self.collectionView reloadData];
                                              
                                              if (_dataSource.count > 0) {
                                                  self.emptyDataView.hidden = YES;
                                              } else {
                                                  self.emptyDataView.hidden = NO;
                                              }
                                              
                                              self.doneButton.enabled = YES;
                                              self.doneButton.tintColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
                                              
                                          } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                              
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                          }];
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

- (void)deletePictureWithID:(NSString *)picID {

    if ([EKSettings getSavedVendor]) {
     
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfilePicture deleteProfessionalPortfolioPictureWithID:picID
                                                       withToken:[EKSettings getSavedVendor].token
                                                       withBlock:^(Professional *professional) {
                                                           
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           
                                                           [EKSettings updateSavedProfessional:professional];
                                                           
                                                           [_dataSource removeAllObjects];
                                                           [_dataSource addObjectsFromArray:[EKSettings getSavedVendor].portfolio];
                                                           [self.collectionView reloadData];
                                                           
                                                           if (_dataSource.count > 0) {
                                                               self.emptyDataView.hidden = YES;
                                                           } else {
                                                               self.emptyDataView.hidden = NO;
                                                           }
                                                           
                                                           _selectedPic = nil;
                                                           self.deleteButton.tintColor = [UIColor clearColor];
                                                           self.deleteButton.enabled = NO;
                                                           
                                                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                           
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                                       }];
        
    } else if ([EKSettings getSavedSalon]) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ProfilePicture deleteSalonPortfolioPictureWithID:picID
                                                withToken:[EKSettings getSavedSalon].token
                                                withBlock:^(Salon *salon) {
                                                    
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    
                                                    [EKSettings updateSavedSalon:salon];
                                                    
                                                    [_dataSource removeAllObjects];
                                                    [_dataSource addObjectsFromArray:[EKSettings getSavedSalon].portfolio];
                                                    [self.collectionView reloadData];
                                                    
                                                    if (_dataSource.count > 0) {
                                                        self.emptyDataView.hidden = YES;
                                                    } else {
                                                        self.emptyDataView.hidden = NO;
                                                    }
                                                    
                                                    _selectedPic = nil;
                                                    self.deleteButton.tintColor = [UIColor clearColor];
                                                    self.deleteButton.enabled = NO;
                                                    
                                                } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                    
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                                }];
    }
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
