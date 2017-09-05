//
//  EKPaymentGatewayViewController.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Payment.h"

#import "EKSettings.h"

#import <Realm/Realm.h>

@interface EKPaymentGatewayViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) Payment *paymentObj;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
