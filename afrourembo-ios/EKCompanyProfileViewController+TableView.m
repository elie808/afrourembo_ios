//
//  EKCompanyProfileViewController+TableView.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKCompanyProfileViewController+TableView.h"

static NSString * const kServicesCell       = @"companyServicesCell";
static NSString * const kReviewsCell        = @"companyReviewsCell";
static NSString * const kProfessionalsCell  = @"companyProfessionalsCell";
static NSString * const kContactsCell       = @"companyContactsCell";
static NSString * const kBioCell            = @"companyProBioCell";

//static NSString * const kLoadingCell        = @"companyProfileLoadingCell";

static NSString * const kProfessionalsCollectionCell = @"companyProfessionalsCollectionCell";

@implementation EKCompanyProfileViewController (TableView)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.passedProfessional) { return 4; }
    
    if (self.passedSalon) { return 4; }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Professionals config
    if (self.passedProfessional) {
        
        switch (section) {
                
            case 0: return 1; break;
                
            case 1: return self.passedProfessional.services.count > 0 ? self.passedProfessional.services.count : 1; break; // Services
                
            case 2: return self.reviewsArray.count > 0 ? self.reviewsArray.count : 1; break; // Reviews

            case 3: return 3; break; // Contacts
                
            default: return 0; break;
        }
    }
    
    // Salon config
    if (self.passedSalon) {

        switch (section) {
                
            case 0: return self.passedSalon.servicesArray.count > 0 ? self.passedSalon.servicesArray.count : 1; break; // Services
                
            case 1: return self.reviewsArray.count > 0 ? self.reviewsArray.count : 1; break; // Reviews
                
            case 2: return self.staffArray.count > 0 ? 1 : 0; break; // Professionals
                
            case 3: return 3; break; // Contacts
                
            default: return 0; break;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Professionals config
    if (self.passedProfessional) {
     
        switch (indexPath.section) {
                
            case 0: { // Bio
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBioCell forIndexPath:indexPath];
                
                cell.textLabel.text = self.passedProfessional.about;
                
                return cell;
                
            } break;
                
            case 1: { // Services
                
                EKCompanyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServicesCell forIndexPath:indexPath];
                
                if (self.passedProfessional.services.count > 0) {
                    
                    Service *serviceObj = [self.passedProfessional.services objectAtIndex:indexPath.row];
                    
                    cell.cellDelegate = self;
                    [cell configureCellForService:serviceObj];
                    
                } else {
                    
                    [cell configureEmptyCell];
                }
                
                return cell;
                
            } break;
                
            case 2: { // Reviews
                
                if (self.reviewsArray.count > 0) {
                
                    EKCompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReviewsCell forIndexPath:indexPath];
                    
                    Review *reviewObj = [self.reviewsArray objectAtIndex:indexPath.row];
                    
                    [cell configureCellForReview:reviewObj];
                    
                    return cell;
                    
                } else { // No reviews available
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBioCell forIndexPath:indexPath];

                    cell.textLabel.text = @"No Reviews";
                    cell.textLabel.textColor = [UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0];
                    
                    return cell;
                }

            } break;
                
            case 3: { // Contacts
                
                EKCompanyContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactsCell forIndexPath:indexPath];
                
                if (self.passedProfessional) {
                    
                    if (indexPath.row == 0) {
                        cell.cellContactTypeLabel.text = @"Name";
                        cell.cellContactValueLabel.text = self.passedProfessional.business.name;
                    }
                    
                    if (indexPath.row == 1) {
                        cell.cellContactTypeLabel.text = @"Phone";
                        cell.cellContactValueLabel.text = self.passedProfessional.phone;
                    }
                    
                    if (indexPath.row == 2) {
                        cell.cellContactTypeLabel.text = @"Address";
                        cell.cellContactValueLabel.text = self.passedProfessional.business.address;
                    }
                }
                
                return cell;
                
            } break;
                
            default: return nil; break;
        }
    }
    
    // Salon config
    if (self.passedSalon) {
        
        switch (indexPath.section) {
                
            case 0: { // Services
                
                EKCompanyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kServicesCell forIndexPath:indexPath];
                
                if (self.passedProfessional.services.count > 0) {
                    
                    Service *serviceObj = [self.passedProfessional.services objectAtIndex:indexPath.row];
                    
                    cell.cellDelegate = self;
                    [cell configureCellForService:serviceObj];
                    
                } else {
                    
                    [cell configureEmptyCell];
                }
                
                return cell;
                
            } break;
                
            case 1: { // Reviews
                
                EKCompanyReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReviewsCell forIndexPath:indexPath];
                
                if (self.reviewsArray.count > 0) {
                    
                    Review *reviewObj = [self.reviewsArray objectAtIndex:indexPath.row];
                    
                    [cell configureCellForReview:reviewObj];
                    
                } else {
                    
                    [cell configureEmptyCell];
                }
                
                return cell;
                
            } break;
                
            case 2: { // Professionals
    
                EKCompanyProfessionalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfessionalsCell forIndexPath:indexPath];
            
                return cell;
    
            } break;
                
            case 3: { // Contacts
                
                EKCompanyContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactsCell forIndexPath:indexPath];
                
                //TODO: Config with proper salon name
                if (self.passedSalon) {
                    
                    if (indexPath.row == 0) {
//                        cell.cellContactTypeLabel.text = @"Name";
//                        cell.cellContactValueLabel.text = self.professional.business.name;
                    }
                    
                    if (indexPath.row == 1) {
//                        cell.cellContactTypeLabel.text = @"Address";
//                        cell.cellContactValueLabel.text = self.professional.business.address;
                    }
                    
                    if (indexPath.row == 2) {
                        //                        cell.cellContactTypeLabel.text = @"Address";
                        //                        cell.cellContactValueLabel.text = self.professional.business.address;
                    }
                }
                
                return cell;
                
            } break;
                
            default: return nil; break;
        }
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat textLabelWidth  = self.tableView.frame.size.width * 0.7; // estimate of how wide a textLabel is
    CGFloat servicesCellHeight  = 82.;
    CGFloat contactCellHeight   = 72.;
    CGFloat professionalsCellHeight   = 110.;
    CGFloat defaultCellHeight   = 44.;
    CGFloat heightOfOtherUIObjects = 110.; // estimated height of other ui elements inside the cell
    
    if (self.passedProfessional) {
        switch (indexPath.section) {
                
            // Bio
            case 0: {
                
                if (self.passedProfessional.about.length > 0) {
                    
                    CGRect textLabelRect = [self.passedProfessional.about
                                            boundingRectWithSize:CGSizeMake(textLabelWidth, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                            context:nil];
                    
                    return textLabelRect.size.height + 16;
                    
                } else {
                    
                    return defaultCellHeight;
                }
            } break;
                
            // Services
            case 1: return servicesCellHeight; break;
                
            // Reviews
            case 2: {
                
                if (self.reviewsArray.count > 0) {
                    
                    Review *reviewObj = [self.reviewsArray objectAtIndex:indexPath.row];
                    
                    CGRect textLabelRect = [reviewObj.review
                                            boundingRectWithSize:CGSizeMake(textLabelWidth, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                            context:nil];
                    
                    return textLabelRect.size.height + heightOfOtherUIObjects; //computed text label height + height of other UI elements
                    
                } else {
                    
                    return defaultCellHeight;
                }
            } break;
                
            // Contacts
            case 3: return contactCellHeight; break;
                
            default: return defaultCellHeight; break;
        }
    }
    
    if (self.passedSalon) {
    
        switch (indexPath.section) {
                
            // Services
            case 0: return servicesCellHeight; break;
                
            // Reviews
            case 1: {
                
                if (self.reviewsArray.count > 0) {
                    
                    Review *reviewObj = [self.reviewsArray objectAtIndex:indexPath.row];
                    
                    CGRect textLabelRect = [reviewObj.review
                                            boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                            context:nil];
                    
                    return textLabelRect.size.height + heightOfOtherUIObjects; // total height = computed label height + other UI elements
                    
                } else {
                    
                    CGRect textLabelRect = [@"No Reviews"
                                            boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                            context:nil];
                    
                    return textLabelRect.size.height + heightOfOtherUIObjects; //computed text label height + height of other UI elements
                }
            } break;
                
            // Professionals
            case 2: return professionalsCellHeight; break;
                
            // Contacts
            case 3: return contactCellHeight; break;
                
            default: return defaultCellHeight; break;
        }
    }
    
    return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (self.passedProfessional) {
        
        switch (section) {
                
            case 0: return @"BIO"; break; // Services
                
            case 1: return @"SERVICES"; break; // Services
                
            case 2: return @"REVIEWS"; break; // Reviews

            case 3: return @"CONTACT INFO"; break; // Contacts
                
            default: return @""; break;
        }
    }
    
    if (self.passedSalon) {
        
        switch (section) {
                
            case 0: return @"SERVICES"; break; // Services
                
            case 1: return @"REVIEWS"; break; // Reviews
                
            case 2: return @"BEAUTY PROFESSIONALS"; break; // Professionals
                
            case 3: return @"CONTACT INFO"; break; // Contacts
                
            default: return @""; break;
        }
    }
    
    return @"";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor = [UIColor whiteColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:22.];
    header.textLabel.textColor = [UIColor blackColor];
    
    if (section == 3) { // CONTACT Section
        
        header.contentView.backgroundColor = [UIColor colorWithRed:51./255. green:51./255. blue:51./255. alpha:1.0];
        header.textLabel.textColor = [UIColor whiteColor];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (self.passedProfessional) {
         
         switch (indexPath.section) {
      
             case 3:
                 
                 if (indexPath.row == 1) { // PHONE
                     if (self.passedProfessional.phone.length > 0) { [self call:self.passedProfessional.phone]; }
                 }
                 
                 break;
                 
             default: break;
         }
     }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    NSInteger index = ((EKInCellCollectionView*)collectionView).collectionIndexPath.row;
    //    Salon *salon = [self.dataSourceArray objectAtIndex:index];
    
    return self.staffArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EKCompanyProfessionalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProfessionalsCollectionCell forIndexPath:indexPath];
    
    Professional *pro = [self.staffArray objectAtIndex:indexPath.row];
    cell.cellNameLabel.text = [NSString stringWithFormat:@"%@ %@", pro.fName, pro.lName];
    [cell.cellImageView yy_setImageWithURL:[NSURL URLWithString:pro.profilePicture] options:YYWebImageOptionProgressive];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Professional *pro = [self.staffArray objectAtIndex:indexPath.row];
    [self getReviewsForVendor:pro.professionalID ofType:kProfessionalType];
}

#pragma mark - EKCompanyServiceCellDelegate

- (void)didTapBookButtonAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.passedProfessional) {
        
        Service *serviceObj = [self.passedProfessional.services objectAtIndex:indexPath.row];
        
        [self performSegueWithIdentifier:kBookingSegue sender:serviceObj];
    }
    
    if (self.passedSalon) { }
}

@end
