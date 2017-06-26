//
//  AppDelegate.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 3/15/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "AppDelegate.h"

static NSString * const kWelcomeStoryboard = @"Welcome";
static NSString * const kMainStoryboard = @"Main";
static NSString * const kVendorMainStoryboard = @"Vendor_Main";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [EKNetworkManager configureRestKit];
    
    // Start at Splash Screen
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kWelcomeStoryboard bundle:nil];
    UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:kSplashVC];
    self.window.rootViewController = rootViewController;

    // Add Service
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
//    UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Availability"];
//    self.window.rootViewController = rootViewController;
    
    // Add Service
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
//    UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"addNewServiceVC"];
//    self.window.rootViewController = rootViewController;
    
    // Explore
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryboard bundle:nil];
//    UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:kExploreVC];
//    self.window.rootViewController = rootViewController;

    // Vendor
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kVendorMainStoryboard bundle:nil];
//    UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:kVendorDashVC];
//    self.window.rootViewController = rootViewController;
    
    // role VC
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
//    UINavigationController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"roleVC"];
//    self.window.rootViewController = rootViewController;

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
    
    return handled;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
