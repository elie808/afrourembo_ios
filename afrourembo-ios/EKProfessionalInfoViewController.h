//
//  EKProfessionalInfoViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 7/4/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Professional.h"
#import "EKAddServiceViewController.h"
#import "EKTextFieldTableViewCell.h"
#import "EKProfessionalInfoTableViewCell.h"
#import "EKProfessionalAddressViewController.h"
#import "ProfessionalInfo+API.h"
#import "Professional+API.h"
#import "EKSettings.h"
#import <MapKit/MapKit.h>

#import "UIViewController+Helpers.h"

@interface EKProfessionalInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) Professional *passedProfessional;

// View Model
@property NSString *businessName;
@property NSString *address;
@property NSString *phoneNumber;
@property CLLocationCoordinate2D addressCoords;
@property (assign, nonatomic) BOOL isMobile;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property NSString *unwindSegueID; // ghetto fix to make view reusable by BP Settings

- (IBAction)unwindToProfessionalInfoVC:(UIStoryboardSegue *)segue;

@end
