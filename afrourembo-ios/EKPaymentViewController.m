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

@implementation EKPaymentViewController {
    NSInteger _totalBookingsValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index = 0;
    _totalBookingsValue = 0;
    
    EKMPesaViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"mpesa_view"];
    EKCreditCardViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"creditCard_view"];
    
    _vcDataSource = @[vc1, vc2];
    
    // Create PageViewController
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    // self.pageViewController.dataSource = self; //un-comment to re-enable swipe gestures on pagecontroller
    [self.pageViewController setViewControllers:@[_vcDataSource.firstObject]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.pageVCPlaceholderView addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    // compute total cost of all bookings
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    for (Booking *bookingObj in _bookingsArray) {
        
        NSString *stringNumber = [bookingObj.bookingCost stringByReplacingOccurrencesOfString:@" KES" withString:@""];

        NSNumber *myNumber = [f numberFromString:stringNumber];
        _totalBookingsValue = _totalBookingsValue + myNumber.integerValue;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // compute tableview length depending on the number of reservations + 1 total row
    self.tableHeightConstraint.constant = ((_bookingsArray.count + 1) * 44) + 8;
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
    return _bookingsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == _bookingsArray.count) {
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cell.textLabel.text = @"Total";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld KES", (long)_totalBookingsValue];
        
    } else {
    
        Booking *booking = [_bookingsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = booking.bookingTitle;
        cell.detailTextLabel.text = booking.bookingCost;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //TODO: Intercept webview responses
    NSLog(@"%@", request);
    
    return YES;
}

#pragma mark - Actions

- (IBAction)didTapPayButton:(UIBarButtonItem *)sender {

    switch (_index) {
            
        case 0: {
            
            EKMPesaViewController *vc1 = _vcDataSource[_index];
            NSLog(@"%@", vc1.MPesaPin);
            
        } break;
        
        case 1: {
          
            EKCreditCardViewController *vc2 = _vcDataSource[_index];
            NSLog(@"%@", vc2._cardNumber);
            [self payWithCreditCard];
            
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

#pragma mark - Helpers

- (void)payWithCreditCard {
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setValue:@"1.0" forKey:@"Mobicard_Version"];
    [params setValue:@"SILENT-HOSTED" forKey:@"Mobicard_Mode"];
    [params setValue:@"3000" forKey:@"Mobicard_Order_Amount"];  // in cents
    [params setValue:@"KES" forKey:@"Mobicard_Order_Currency"]; // try to infer from somewhere
    [params setValue:@"itemDescriptionHere" forKey:@"Mobicard_Item_Description"]; // service+pro+client
    [params setValue:@"1234567" forKey:@"Mobicard_Transaction_Reference"]; // bookingID
    
    [params setValue:@"FirstName" forKey:@"Mobicard_First_Name"];   // get First Name
    [params setValue:@"LastName" forKey:@"Mobicard_Last_Name"];     // get Last Name
    [params setValue:@"Some Address" forKey:@"Mobicard_Address"];   // get Adress
    [params setValue:@"0000" forKey:@"Mobicard_Postal_Code"];   // <20 chars
    
    [params setValue:@"KEN" forKey:@"Mobicard_Country_Code"];
    [params setValue:[EKSettings getSavedCustomer].phone forKey:@"Mobicard_Mobile_Number"];
    [params setValue:[EKSettings getSavedCustomer].email forKey:@"Mobicard_Email"];
    [params setValue:@"CARD" forKey:@"Mobicard_Payment_Type"];
    [params setValue:@"1" forKey:@"Mobicard_Payment_Set"];
    
    [params setValue:@"4242424242424242424" forKey:@"Mobicard_Cnumber"];
    [params setValue:@"100" forKey:@"Mobicard_Cvv"];
    [params setValue:@"02" forKey:@"Mobicard_Cexp_Month"];
    [params setValue:@"2019" forKey:@"Mobicard_Cexp_Year"];
    
    [params setValue:kMerchantID forKey:@"Mobicard_MerchantID"];
    [params setValue:kMobicardAPIKey forKey:@"Mobicard_API_Key"];
    
    [self presentWebViewForData:params];
}

- (void)presentWebViewForData:(NSDictionary *)paramDictionary {
    
    NSURL *url = [NSURL URLWithString:kMobicardURL];
    
    //convert dictionary to JSON to send in webform
    NSError *error;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:paramDictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest * request = [NSMutableURLRequest
                                     requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsondata];
    
    // load the request in the UIWebView.
    UIWebView *buyView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    buyView.backgroundColor = [UIColor whiteColor];
    buyView.scalesPageToFit = YES;
    buyView.delegate = self;
    [buyView loadRequest:request];
    
    [self.view addSubview:buyView];
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
