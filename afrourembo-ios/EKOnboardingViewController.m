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
    
    /*
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Tutorial 1";
    page1.desc = @"EXPLORE SALONS AND PROFESSIONALS NEAR YOU";
    page1.bgColor = [UIColor redColor];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Tutorial 2";
    page2.desc = @"FIND AND BOOK THE BEST BEAUTY SERVICES";
    page2.bgColor = [UIColor blueColor];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Tutorial 3";
    page3.desc = @"RATE AND SAVE FAVORITED PROFESSIONALS";
    page3.bgColor = [UIColor blueColor];
    */
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"EXPLORE SALONS AND PROFESSIONALS NEAR YOU";
    page1.titleFont = [UIFont boldSystemFontOfSize:26];
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"FIND AND BOOK THE BEST BEAUTY SERVICES";
    page2.titleFont = [UIFont boldSystemFontOfSize:26];
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"RATE AND SAVE FAVORITED PROFESSIONALS";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleFont = [UIFont boldSystemFontOfSize:26];
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(didTapSignUpButton:) forControlEvents:UIControlEventTouchDown];
    
    self.introView.backgroundColor = [UIColor grayColor];
    self.introView.skipButton = skipButton;
    [self.introView setDelegate:self];
    [self.introView setPages:@[page1, page2, page3]];
    
    [self.introView showInView:self.view animateDuration:0.0];
}

#pragma mark - Actions

- (IBAction)didTapSignUpButton:(id)sender {
    
    [self performSegueWithIdentifier:kRoleSegue sender:nil];
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
