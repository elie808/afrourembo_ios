//
//  EKBusinessModelViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BusinessModelUser) {
    BusinessModelUserIndependentBP,
    BusinessModelUserWorksInSalonBP
};

@interface EKBusinessModelViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) BusinessModelUser BusinessModelUser;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
