//
//  EKPaymentGatewayViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKPaymentGatewayViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
