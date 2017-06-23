//
//  EKSalonInfoViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "EKTextFieldTableViewCell.h"
#import <MapKit/MapKit.h>

@interface EKSalonInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// View model
@property NSString *companyName;
@property NSString *role;
@property NSString *address;
@property CLLocationCoordinate2D addressCoords;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapSubmit:(id)sender;

@end
