//
//  EKPaymentGatewayViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKPaymentGatewayViewController.h"

//0.01667 is roughly 1/60, so it will update at 60 FPS
static const NSTimeInterval kTimer = 0.01667;

@implementation EKPaymentGatewayViewController {
    BOOL _webViewDidLoad;
    NSTimer *_loadTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *htmlFileURL = [[NSBundle mainBundle] URLForResource:@"payment_gateway" withExtension:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFileURL.path encoding:NSUTF8StringEncoding error:nil];

    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"itemDescriptionVAR" withString:self.paymentObj.description];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"currencyVAR" withString:self.paymentObj.currency];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"orderAmountVAR"
                                                       withString:[NSString stringWithFormat:@"%@", self.paymentObj.orderTotal]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"fNameVAR" withString:self.paymentObj.fName];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"lNameVAR" withString:self.paymentObj.lName];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"emailVAR" withString:self.paymentObj.email];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"mobileVAR" withString:self.paymentObj.mobile];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"bookingID" withString:self.paymentObj.bookingID];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
