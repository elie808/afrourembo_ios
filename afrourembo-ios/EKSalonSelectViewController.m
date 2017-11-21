//
//  EKSalonSelectViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/25/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKSalonSelectViewController.h"

static NSString * const kSalonSelectCell = @"salonSelectCell";
static NSString * const kServiceSegue = @"salonSelectToServiceVC";

@implementation EKSalonSelectViewController {
    NSMutableArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select your salon";
    
//    Salon *salon1 = [Salon new];
//    salon1.userName = @"Salon 1";
//    salon1.isCentralizedModel = YES;
//    
//    Salon *salon2 = [Salon new];
//    salon2.userName = @"Salon 2";
//    salon2.isCentralizedModel = YES;
//    
//    Salon *salon3 = [Salon new];
//    salon3.userName = @"Salon 3";
//    salon3.isCentralizedModel = NO;
//    
//    Salon *salon4 = [Salon new];
//    salon4.userName = @"Salon 4";
//    salon4.isCentralizedModel = NO;
//    
//    _dataSourceArray = [NSMutableArray arrayWithObjects:salon1, salon2, salon3, salon4, nil];
    _dataSourceArray = [NSMutableArray new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EKSalonSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSalonSelectCell forIndexPath:indexPath];

    Salon *salonObj = [_dataSourceArray objectAtIndex:indexPath.row];
    
    cell.cellTextLabel.text = salonObj.name;
    
    if (salonObj.isCentralizedModel) {
    
        cell.cellImageView.image = [UIImage imageNamed:@"icCentered"];
    
    } else {
        
        cell.cellImageView.image = [UIImage imageNamed:@"icDecentrilized"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:kServiceSegue sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([segue.identifier isEqualToString:kServiceSegue]) {
        
        EKAddServiceViewController *vc = segue.destinationViewController;
        vc.passedProfessional = self.passedProfessional;
    }
}

@end
