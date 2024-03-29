//
//  EKPaymentGatewayViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKPaymentGatewayViewController.h"

//0.01667 is roughly 1/60, so it will update at 60 FPS
static const NSTimeInterval kTimer  = 0.01667;
static NSString * const kSuccessVC = @"paymentVCToCheckoutSucessVC";
static NSString * const kSuccessWebURL = @"http://35.158.118.170/successpage.html";


@implementation EKPaymentGatewayViewController {
    BOOL _webViewDidLoad;
    NSTimer *_loadTimer;
    RLMResults<Booking *> *_bookings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide Done UIBarItemButton
    self.doneButton.enabled = NO;
    self.doneButton.tintColor = [UIColor clearColor];
    
    // load the cached cart items
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"bookingOwner = %@", [EKSettings getSavedCustomer].email];
    _bookings = [Booking objectsWithPredicate:pred];
    
    NSURL *htmlFileURL = [[NSBundle mainBundle] URLForResource:@"payment_gateway" withExtension:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFileURL.path encoding:NSUTF8StringEncoding error:nil];

    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"itemDescriptionVAR"
                  withString:self.paymentObj.descriptionText.length > 0 ? self.paymentObj.descriptionText : @""];
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"currencyVAR"
                  withString:self.paymentObj.currency.length > 0 ? self.paymentObj.currency : @""];
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"orderAmountVAR"
                  withString:[NSString stringWithFormat:@"%@", self.paymentObj.orderTotal]];
    
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"fNameVAR"
                  withString:self.paymentObj.fName.length > 0 ? self.paymentObj.fName : @""];
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"lNameVAR"
                  withString:self.paymentObj.lName.length > 0 ? self.paymentObj.lName : @""];
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"emailVAR"
                  withString:self.paymentObj.email.length > 0 ? self.paymentObj.email : @""];
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"mobileVAR"
                  withString:self.paymentObj.mobile.length > 0 ? self.paymentObj.mobile : @""];
    
    htmlString = [htmlString
                  stringByReplacingOccurrencesOfString:@"bookingID"
                  withString:self.paymentObj.bookingID.length > 0 ? self.paymentObj.bookingID : @""];

    [self.webView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    _webViewDidLoad = NO;
    
    _loadTimer = [NSTimer scheduledTimerWithTimeInterval:kTimer target:self selector:@selector(timerCallback) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_loadTimer forMode:NSDefaultRunLoopMode];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    _webViewDidLoad = YES;
    [_loadTimer invalidate];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *URLString = [[request URL] absoluteString];
    
    NSLog(@"URL: %@", URLString);
    
    // user directed to "succesful payment" webPage
    if ([URLString isEqualToString:kSuccessWebURL]) {
        
//        self.doneButton.enabled = YES;
//        self.doneButton.tintColor = [UIColor whiteColor];

        self.cancelButton.enabled = NO;
        self.cancelButton.tintColor = [UIColor clearColor];
        
        // if booking succesful, remove all cached cart items
        for (Booking *bookingObj in _bookings) {
            [[RLMRealm defaultRealm] beginWriteTransaction];
            [[RLMRealm defaultRealm] deleteObject:bookingObj.reservation];
            [[RLMRealm defaultRealm] deleteObject:bookingObj];
            [[RLMRealm defaultRealm] commitWriteTransaction];
        }
        
        [self performSegueWithIdentifier:kSuccessVC sender:nil];
    }

    return YES;
}

#pragma mark - Actions

- (void)timerCallback {
    
    if (_webViewDidLoad) {
        
        if (self.progressView.progress >= 1) {
            
            self.progressView.hidden = YES;
            [_loadTimer invalidate];
            
        } else {
            
            self.progressView.progress = self.progressView.progress + 0.1;
        }
        
        // DONE
        [self.progressView setProgress:1.0 animated:YES];
        
    } else { // Update bar
        
        self.progressView.progress = self.progressView.progress + 0.05;
        
        // hold bar at 95% until all ressources are loaded
        if (self.progressView.progress >= 0.95) {
            self.progressView.progress = 0.95;
            
        }
        
        [NSTimer scheduledTimerWithTimeInterval:kTimer target:self selector:@selector(timerCallback) userInfo:nil repeats:NO];
    }
}

- (IBAction)didTapDoneButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:kSuccessVC sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSuccessVC]) {
    }
}

@end
