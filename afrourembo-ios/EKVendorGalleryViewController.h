//
//  EKVendorGalleryViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYWebImage/YYWebImage.h>

#import "EKConstants.h"
#import "EKSettings.h"
#import "EKVendorGalleryCollectionViewCell.h"
#import "ProfilePicture+API.h"

#import "UIImage+Helpers.h"
#import "UIViewController+Helpers.h"

@interface EKVendorGalleryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (strong, nonatomic) IBOutlet UIView *emptyDataView;
@property (strong, nonatomic) IBOutlet UIButton *addPicturesButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)didTapAddPhotoPicture:(id)sender;
- (IBAction)deletePictures:(id)sender;

@end
