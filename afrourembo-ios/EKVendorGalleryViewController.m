//
//  EKVendorGalleryViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKVendorGalleryViewController.h"

static int const kMaxImageSize = 0.3; //MBs

static NSString * const kGalleryCell  = @"galleryCell";

@implementation EKVendorGalleryViewController {
    NSMutableArray *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyDataView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y,
                                          self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.emptyDataView.hidden = NO;
    [self.view addSubview:self.emptyDataView];
    [self.view bringSubviewToFront:self.addPicturesButton]; // make the button float on top of the empty data view
    
    _dataSource = [NSMutableArray arrayWithArray:[EKSettings getSavedVendor].portfolio];
    
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
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Pictures *pic = [_dataSource objectAtIndex:indexPath.row];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ProfilePicture deleteProfessionalPortfolioPictureWithID:pic.pictureID
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
                                                       
                                                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                     
                                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                       [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                                  }];
}

#pragma mark - Actions

- (IBAction)didTapAddPhotoPicture:(id)sender {
    
    [self presentAlertController];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
                                                 
                                             } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                            }];
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
