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
#import <MapKit/MapKit.h>

@interface EKProfessionalInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) Professional *passedProfessional;

// View Model
@property NSString *businessName;
@property NSString *address;
@property NSString *phoneNumber;
@property CLLocationCoordinate2D addressCoords;
@property (assign, nonatomic) BOOL isMobile;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)unwindToProfessionalInfoVC:(UIStoryboardSegue *)segue;

@end
