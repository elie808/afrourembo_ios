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
     
    if (!self.passedService) {
        
        //TODO: Regular Search - Fetch all
        
    } else {
        
        [Explore getProfessionalsForCategory:self.passedService.name
                                  andService:nil
                                   WithBlock:^(NSArray<Professional *> *proArray) {
                                     
                                       _listViewVisible = NO;
                                       
                                       self.contentOffsetDictionary = [NSMutableDictionary new];
                                       self.venuesList = [NSArray arrayWithArray:proArray];
                                       
                                       self.dataSourceArray = [NSMutableArray arrayWithArray:self.venuesList];
                                       [self.tableView reloadData];
                                       [self placeVenuePins:self.dataSourceArray];
                                       
                                   } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
                                      [self showMessage:errorMessage withTitle:@"Error" completionBlock:nil];
                                  }];
        
        //TODO: Service specific
//        [Explore getExploreLocationsForUser:self.passedCustomer.token
//                                  WithBlock:^(Explore *exploreObj) {
//                                    
//                                      NSLog(@"EXPLORE: %@", exploreObj);
//                                      
//                                      _listViewVisible = NO;
//                                      
//                                      self.contentOffsetDictionary = [NSMutableDictionary new];
//                                      self.venuesList = exploreObj.professionals;
//                                      
////                                      self.venuesList = [self createStubs];//exploreObj.professionals;
//                                      self.dataSourceArray = [NSMutableArray arrayWithArray:self.venuesList];
//                                      [self.tableView reloadData];
//                                      [self placeVenuePins:self.dataSourceArray];
//
//                                  } withErrors:^(NSError *error, NSString *errorMessage, NSInteger statusCode) {
//                                     
//                                 }];
    }
    
    [self initLayout];
    
//    [self initDataSources];
}

#pragma mark - Actions

- (IBAction)didTapPresentListButton:(UIButton *)sender {
    
    if (!_listViewVisible) {
    
        [self.dataSourceArray removeAllObjects];
        [self.dataSourceArray addObjectsFromArray:self.venuesList];
        [self.tableView reloadData];
    }
    
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

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     if ([segue.identifier isEqualToString:kCompanyProfile]) {
         
         EKCompanyProfileViewController *vc = segue.destinationViewController;
         
         if ([sender isKindOfClass:[Professional class]]) {
             vc.professional = (Professional *)sender;
         }
         
         if ([sender isKindOfClass:[Salon class]]) {
             vc.salon = (Salon *)sender;
         }
     }
}

#pragma mark - Helpers

- (void)animateOneCellList:(BOOL)show {
    
    CGRect visibleCellFrame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y,
                                         self.mapView.frame.size.width, 230);
    
    CGRect hiddenCellFrame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.size.height,
                                        self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    [UIView animateWithDuration:0.6
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{

                         self.tableView.frame = show ? visibleCellFrame : hiddenCellFrame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)initDataSources {

    _listViewVisible = NO;
    
    self.contentOffsetDictionary = [NSMutableDictionary new];
//    self.venuesList = [self createStubs];
    self.dataSourceArray = [NSMutableArray arrayWithArray:self.venuesList];
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

@end
