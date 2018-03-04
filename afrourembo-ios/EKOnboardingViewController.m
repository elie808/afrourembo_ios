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
    page1.bgImage = [UIImage imageNamed:@"obg3"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"FIND AND BOOK THE BEST BEAUTY SERVICES";
    page2.titleFont = [UIFont boldSystemFontOfSize:26];
    page2.bgImage = [UIImage imageNamed:@"obg2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"RATE AND SAVE FAVORITED PROFESSIONALS";
    page3.bgImage = [UIImage imageNamed:@"obg1"];
    page3.titleFont = [UIFont boldSystemFontOfSize:26];
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setTitle:@"Sign up" forState:UIControlStateNormal];
    [skipButton setTintColor:[UIColor colorWithRed:255./255. green:195./255. blue:0./255. alpha:1.0]];
    [skipButton addTarget:self action:@selector(didTapSignUpButton:) forControlEvents:UIControlEventTouchDown];
    
    self.introView.backgroundColor = [UIColor grayColor];
    self.introView.skipButton = skipButton;
    [self.introView setDelegate:self];
    self.introView.swipeToExit = NO;
    [self.introView setPages:@[page1, page2, page3]];
    
    [self.introView showInView:self.view animateDuration:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(autoScrollPage) userInfo:nil repeats:YES];
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

#pragma mark - Helpers

- (void)autoScrollPage {
    
    if (self.introView.visiblePageIndex+1 < self.introView.pages.count) {
        [self.introView scrollToPageForIndex:self.introView.visiblePageIndex+1 animated:YES];
    }
}

@end
