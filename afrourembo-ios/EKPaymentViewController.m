//
//  EKPaymentViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/14/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import "EKPaymentViewController.h"
#import "EKCreditCardViewController.h"
#import "EKMPesaViewController.h"


@implementation EKPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index = 0;
    
    // compute tableview length depending on the number of reservations
    CGFloat tableHeight = 20;//(_bookingsArray.count * 44) + 8;
    
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y,
                                      self.tableView.frame.size.width, tableHeight);
    
    // Create PageViewController
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.view.frame = CGRectMake(0,
                                                    self.segmentedControl.frame.origin.y + 8,
                                                    self.view.frame.size.width,
                                                    self.view.frame.size.height - self.tableView.frame.size.height - 46);
    // self.pageViewController.dataSource = self; //un-comment to re-enable swipe gestures on pagecontroller
    
    EKMPesaViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"mpesa_view"];
    EKCreditCardViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"creditCard_view"];
    
    _vcDataSource = @[vc1, vc2];
        
    [self.pageViewController setViewControllers:@[_vcDataSource.firstObject]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - PageViewController DataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (_index > 0 && _index < _vcDataSource.count-1) {
        _index--;
    } else {
        return nil;
    }
    
    return [self viewControllerAtIndex:_index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    if (_index < _vcDataSource.count-1) {
        _index++;
    } else {
        return nil;
    }
    
    return [self viewControllerAtIndex:_index];
}


- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    return _vcDataSource[index];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bookingsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Booking *booking = [_bookingsArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = booking.bookingTitle;
    cell.detailTextLabel.text = booking.bookingCost;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)didTapPayButton:(UIBarButtonItem *)sender {

    switch (_index) {
            
        case 0: {
            
            NSLog(@"MPESA BABY");
            EKMPesaViewController *vc1 = _vcDataSource[_index];
            NSLog(@"%@", vc1.MPesaPin);
            
        } break;
        
        case 1: {
          
            NSLog(@"CREDIT CARD ON DECK");
            EKCreditCardViewController *vc2 = _vcDataSource[_index];
            NSLog(@"%@", vc2._cardNumber);
            
        } break;
            
        default: break;
    }
    
}

- (IBAction)didChangeSegmented:(UISegmentedControl *)sender {

    _index = sender.selectedSegmentIndex;
    
    if (sender.selectedSegmentIndex == 0) {
 
        [self.pageViewController setViewControllers:@[_vcDataSource[sender.selectedSegmentIndex]]
                                          direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    } else if (sender.selectedSegmentIndex == 1) {
    
        [self.pageViewController setViewControllers:@[_vcDataSource[sender.selectedSegmentIndex]]
                                          direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
