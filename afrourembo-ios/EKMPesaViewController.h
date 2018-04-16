//
//  EKMPesaViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/15/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextFieldTableViewCell.h"

@interface EKMPesaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel; //still not sure of the proper use of that number

// viewModel
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *MPesaPin;

- (BOOL)validateData;

@end
