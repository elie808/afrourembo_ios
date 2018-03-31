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
    
    /// used as data source for the full screen photo gallery
    NSMutableArray *_photoGalleryDataSource;
    
    /// used to delete vendor from favorites. Obviously different that userID. Obviously dumb as fuck
    NSString *_vendorUserID;
    
    /// to decide whether a vendor should be favorited or unfavorited by the favoritesButton
    BOOL _canFavoriteVendor;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureFavoritesButton];
}

- (void)configureFavoritesButton {
    
    if ( (self.passedCustomer && self.passedCustomer.token) || ([EKSettings getSavedCustomer] && [EKSettings getSavedCustomer].token) ) {
        
        self.favoritesButton.hidden = NO;

        _canFavoriteVendor = YES; // default
        [self.favoritesButton setImage:[UIImage imageNamed:@"icNoFav"] forState:UIControlStateNormal];
        
        // check if vendor is already favorited by user
        for (Favorite *favObj in [EKSettings getSavedCustomer].favorites) {
            
            if ([_vendorID isEqualToString:favObj.userId]) {
                
                _vendorUserID = favObj.serverID;
                _canFavoriteVendor = NO;
                [self.favoritesButton setImage:[UIImage imageNamed:@"icFavorites"] forState:UIControlStateNormal];
            }
        }
        
    } else {
        
        self.favoritesButton.hidden = YES;
    }
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
        
        self.photoCountLabel.text = [NSString stringWithFormat:@"%lu photos", (unsigned long)self.passedProfessional.portfolio.count];
        
        if (self.passedProfessional.portfolio.count > 0) {
        
            NSMutableArray *picLinksArray = [NSMutableArray new];
            
            for (Pictures *pic in self.passedProfessional.portfolio) {
                [picLinksArray addObject:pic.picture];
                [_photoGalleryDataSource addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pic.picture]]];
            }
            
            [self.carousel configureWithVenueImages:picLinksArray];
            
        } else {
            
//            [self.carousel configureWithVenueImages:@[[MWPhoto photoWithImage:[UIImage imageNamed:@"brush_tableview"]]]];
        }

    } else if (self.passedSalon) {
        
        self.starsImageView.image = [UIImage imageForStars:self.passedSalon.rating];
        
        self.photoCountLabel.text = [NSString stringWithFormat:@"%lu photos", (unsigned long)self.passedSalon.portfolio.count];
        
        if (self.passedSalon.portfolio.count > 0) {
        
            NSMutableArray *picLinksArray = [NSMutableArray new];
            
            for (Pictures *pic in self.passedSalon.portfolio) {
                [picLinksArray addObject:pic.picture];
                [_photoGalleryDataSource addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pic.picture]]];
            }
            
            [self.carousel configureWithVenueImages:picLinksArray];
            
        } else {
           
//            [self.carousel configureWithVenueImages:@[[MWPhoto photoWithImage:[UIImage imageNamed:@"brush_tableview"]]]];
        }
        
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
    
    if (_canFavoriteVendor) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Customer postFavorite:_vendorID vendorType:_vendorType withToken:[EKSettings getSavedCustomer].token
                     withBlock:^(Favorite *favoriteObj) {

                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         
                         // update localy saved user
                         Customer *savedCustomer = [EKSettings getSavedCustomer];
                         NSMutableArray *temp = [NSMutableArray arrayWithArray:savedCustomer.favorites];
                         [temp addObject:favoriteObj];
                         savedCustomer.favorites = [NSArray arrayWithArray:temp];
                         [EKSettings updateSavedCustomer:savedCustomer];
                         
                         _canFavoriteVendor = NO;
                         _vendorUserID = favoriteObj.serverID; // to allow unfavoring vendor without navigating back
                         [self.favoritesButton setImage:[UIImage imageNamed:@"icFavorites"] forState:UIControlStateNormal];
                         
                     } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                     }];
        
    } else {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Customer deleteFavorite:_vendorUserID
                       withToken:[EKSettings getSavedCustomer].token
                       withBlock:^(Favorite *favoriteObj) {

                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           
                           // update localy saved user
                           Customer *savedCustomer = [EKSettings getSavedCustomer];
                           NSMutableArray *temp = [NSMutableArray arrayWithArray:savedCustomer.favorites];
                           
                           NSUInteger favIndex = 69000; // hacky way to initialize this var. Using a huge number that'll "probably not occur"
                           for (Favorite *favObj in temp) {
                               if ([_vendorID isEqualToString:favObj.userId]) {
                                   favIndex = [temp indexOfObject:favObj];
                               }
                           }
                           
                           if (favIndex < 69000) {
                               [temp removeObjectAtIndex:favIndex];
                           }
                           
                           savedCustomer.favorites = [NSArray arrayWithArray:temp];
                           [EKSettings updateSavedCustomer:savedCustomer];
                           
                           _canFavoriteVendor = YES;
                           [self.favoritesButton setImage:[UIImage imageNamed:@"icNoFav"] forState:UIControlStateNormal];
                           
                       } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                           
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                       }];
    }
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
