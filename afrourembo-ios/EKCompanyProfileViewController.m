//
//  EKCompanyProfileViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController.h"
#import "EKCompanyProfileViewController+TableView.h"

@implementation EKCompanyProfileViewController {
    NSString *_vendorID;
    NSString *_vendorType;
    NSMutableArray *_photoGalleryDataSource; // Used as data source for the full screen photo gallery
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reviewsArray = [NSMutableArray new];
    self.staffArray = [NSMutableArray new];

    if (self.passedProfessional) {
        
        self.title = [NSString stringWithFormat:@"%@ %@", self.passedProfessional.fName, self.passedProfessional.lName];
        
        _vendorID = self.passedProfessional.professionalID;
        _vendorType = kProfessionalType;
        
        [self getReviewsForVendor:_vendorID ofType:_vendorType];
        
    } else if (self.passedSalon) {
        
        self.title = self.passedSalon.name;
        
        _vendorID = self.passedSalon.salonID;
        _vendorType = kSalonType;
        
        [self getStaff];
    }
    
    [self configureCarousel];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photoGalleryDataSource.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < _photoGalleryDataSource.count) {
        return [_photoGalleryDataSource objectAtIndex:index];
    }
    
    return nil;
}

#pragma mark - Helpers

- (void)configureCarousel {
    
    _photoGalleryDataSource = [NSMutableArray new];
    
    if (self.passedProfessional) {
        
        self.starsImageView.image = [UIImage imageForStars:self.passedProfessional.rating];
        
        NSMutableArray *picLinksArray = [NSMutableArray new];
        
        for (Pictures *pic in self.passedProfessional.portfolio) {
            [picLinksArray addObject:pic.picture];
            [_photoGalleryDataSource addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pic.picture]]];
        }
        
        [self.carousel configureWithVenueImages:picLinksArray];
        
        self.photoCountLabel.text = [NSString stringWithFormat:@"%lu photos", (unsigned long)picLinksArray.count];
        
    } else if (self.passedSalon) {
        
        self.starsImageView.image = [UIImage imageForStars:self.passedSalon.rating];
        
        NSMutableArray *picLinksArray = [NSMutableArray new];
        
        for (Pictures *pic in self.passedSalon.portfolio) {
            [picLinksArray addObject:pic.picture];
            [_photoGalleryDataSource addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pic.picture]]];
        }
        
        [self.carousel configureWithVenueImages:picLinksArray];
        
        self.photoCountLabel.text = [NSString stringWithFormat:@"%lu photos", (unsigned long)picLinksArray.count];
    }
}

- (void)getReviewsForVendor:(NSString *)vendorID ofType:(NSString *)vendorType {

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Review getReviewsForVendor:vendorID
                         ofType:vendorType
                      withToken:self.passedCustomer.token
                      withBlock:^(NSArray<Review *> *reviewsArray) {
    
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          if (reviewsArray.count > 0) {
                              self.reviewsArray = [NSMutableArray arrayWithArray:reviewsArray];
                              [self.tableView reloadData];
                          }
                      }
                     withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                     }];
}

- (void)getStaff {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [Salon getStaffForSalon:self.passedSalon.salonID
                forCustomer:[EKSettings getSavedCustomer].token
                  withBlock:^(NSArray<Professional *> *staffArray) {

                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self.staffArray addObjectsFromArray:staffArray];
                      [self.tableView reloadData];
                      
                  } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                      
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                 }];
}

- (void)call:(NSString *)phoneNumber {
    
    NSString *unspacedPhoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", unspacedPhoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneNumberURL]) {
        
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
        
    } else {
        
    }
}

- (void)showPhotoGallery {
    
    // Create browser (must be done each time photo browser is displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    // browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    // [browser setCurrentPhotoIndex:1];
    
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - Actions

- (IBAction)didTapShowGallery:(id)sender {
    [self showPhotoGallery];
}

- (IBAction)didTapFavoriteButton:(id)sender {
    
    [Customer postFavorite:_vendorID vendorType:_vendorType withToken:[EKSettings getSavedCustomer].token
                 withBlock:^(NSArray<Favorite *> *favoriteObj) {
                     [self showMessage:@"Added to favorites!" withTitle:@"Success" completionBlock:nil];
                 } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                     [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                 }];
    
//    [Customer deleteFavorite:_vendorID
//                   withToken:[EKSettings getSavedCustomer].token
//                   withBlock:^(NSArray<Favorite *> *favoriteObj) {
//                       [self showMessage:@"Removed from favorites!" withTitle:@"Success" completionBlock:nil];
//                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
//                      [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
//                  }];
    
}

- (IBAction)didTapInstagramButton:(id)sender {
    
}

- (IBAction)didTapFacebookButton:(id)sender {
    
}

- (IBAction)didTapTwitterButton:(id)sender {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kBookingSegue]) {
        
        EKBookingViewController *vc = [segue destinationViewController];
        
        if (sender && [sender isKindOfClass:[Service class]]) {
            vc.passedService = (Service *)sender;
        }
        
        if (self.passedProfessional) {
        
            vc.professionalsDataSource = @[self.passedProfessional];
            vc.salonId = @"-1";
            vc.salonName = @"-1";
            
        } else if (self.passedSalon) {
            
            vc.professionalsDataSource = @[self.passedSalon.selectedProfessional];
            vc.salonId = self.passedSalon.salonID;
            vc.salonName = self.passedSalon.name;
        }
    }
}

@end
