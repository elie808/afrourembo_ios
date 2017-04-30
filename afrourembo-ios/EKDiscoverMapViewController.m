//
//  EKDiscoverMapViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/11/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKDiscoverMapViewController.h"
#import "EKDiscoverMapViewController+MapDelegate.h"
#import "EKDiscoverMapViewController+TableView.h"

@implementation EKDiscoverMapViewController {
    BOOL _listViewVisible; // keep track if tableView is visible or not. Animate toggleButton accordingly
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initLayout];
    
    [self initDataSources];
}

#pragma mark - Actions

- (IBAction)didTapPresentListButton:(UIButton *)sender {
    
    CGRect visibleListFrame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y,
                                      self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    CGRect hiddenListFrame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.size.height,
                                      self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    [UIView animateWithDuration:0.6
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.tableView.frame = _listViewVisible ? hiddenListFrame : visibleListFrame;
                     }
                     completion:^(BOOL finished) {
                         
                         _listViewVisible = !_listViewVisible;
                         
                         _listViewVisible ?
                         [self.toggleButton setImage:[UIImage imageNamed:@"icXListView"] forState:UIControlStateNormal] :
                         [self.toggleButton setImage:[UIImage imageNamed:@"icListView"] forState:UIControlStateNormal];
                     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helpers

- (void)initDataSources {
    
    self.contentOffsetDictionary = [NSMutableDictionary new];
    self.dataSourceArray = [self createStubs];
    [self placeVenuePins:self.dataSourceArray];
}

- (void)initLayout {
    
    _listViewVisible = NO;
    
    self.toggleButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.toggleButton.layer.shadowOpacity = 0.3;
    self.toggleButton.layer.shadowRadius = 1;
    self.toggleButton.layer.shadowOffset = CGSizeMake(0, 3.5f);
    
    self.navigationItem.titleView = self.searchBar;
    
    // to ensure the toggleButton is always visible as the topmost view (could use layer.zPosition = MAXFLOAT as an alternative)
    [self.view insertSubview:self.tableView belowSubview:self.toggleButton];
    
    self.tableView.frame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.size.height,
                                      self.mapView.frame.size.width, self.mapView.frame.size.height);
}

//TODO: REMOVE AFTER TESTING
- (NSArray *)createStubs {
    
    Salon *salon = [Salon new];
    salon.mainImageName = @"dummy_portrait1";
    salon.stars = @5;
    salon.price = @30;
    salon.photoCount = @10;
    salon.userImageName = @"dummy_male1";
    salon.userName = @"Adele Hampton";
    salon.address = @"Muindi Mbingu St.";
    salon.latitude = -1.271536; //33.883630;
    salon.longitude = 36.845736; //35.495480;
    salon.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM"];
    
    Salon *salon1 = [Salon new];
    salon1.mainImageName = @"dummy_portrait2";
    salon1.stars = @2;
    salon1.price = @300;
    salon1.photoCount = @100;
    salon1.userImageName = @"dummy_male1";
    salon1.userName = @"James Lipton";
    salon1.address = @"More of Muindi Mbingu St.";
    salon1.latitude = -1.291536;
    salon1.longitude = 36.825736;
    salon1.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM", @"1:30 PM", @"Tue", @"8:20 AM", @"12:55 PM"];
    
    Salon *salon3 = [Salon new];
    salon3.mainImageName = @"dummy_portrait3";
    salon3.stars = @5;
    salon3.price = @30;
    salon3.photoCount = @10;
    salon3.userImageName = @"dummy_male2";
    salon3.userName = @"James Earl Lipton";
    salon3.address = @"Muindi Mbingu St.";
    salon3.latitude = -1.331536;
    salon3.longitude = 36.805736;
    salon3.timesArray = @[@"Today", @"9:00 AM"];
    
    Salon *salon4 = [Salon new];
    salon4.mainImageName = @"dummy_portrait5";
    salon4.stars = @5;
    salon4.price = @300;
    salon4.photoCount = @10;
    salon4.userImageName = @"dummy_male1";
    salon4.userName = @"Twinning Matumbo";
    salon4.address = @"Konakri Mbingu St.";
    salon4.latitude = -1.391536;
    salon4.longitude = 36.905736;
    salon4.timesArray = @[@"Today", @"9:00 AM", @"12:15 PM", @"1:30 PM", @"Tue", @"8:20 AM", @"12:55 PM"];
    
    return @[salon, salon1, salon3, salon4];
}

@end
