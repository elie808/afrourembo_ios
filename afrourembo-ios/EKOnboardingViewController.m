//
//  EKOnboardingViewController.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKOnboardingViewController.h"

static NSString * const kRoleSegue = @"onboardingToRole";

@implementation EKOnboardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // basic
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Tutorial 1";
    page1.desc = @"DESCRIPTIONNN goes here for tutorial 1";
    page1.bgColor = [UIColor redColor];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Tutorial 2";
    page2.desc = @"DESCRIPTIONNN goes here for tutorial 2";
    page2.bgColor = [UIColor blueColor];
    
    self.introView.backgroundColor = [UIColor grayColor];
    self.introView.skipButton = nil;
    [self.introView setDelegate:self];
    [self.introView setPages:@[page1, page2]];
    
    [self.introView showInView:self.view animateDuration:0.0];
}

#pragma mark - EAIntroDelegate

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    
    [self performSegueWithIdentifier:kRoleSegue sender:nil];
}

- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
