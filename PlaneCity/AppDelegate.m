//
//  AppDelegate.m
//  PlaneCity
//
//  Created by GlennChiu on 5/27/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "public.h"
#import "WelcomeViewController.h"
#import "PlaneNavigationController.h"
#import "LeftMenuTableViewController.h"
#import "AppConstant.h"
#import "common.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "KIProgressViewManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.isFBLogged = self.isLILogged = self.isEMLogged = FALSE;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setBarTintColor:COLOR_TINT];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    NSDictionary * navBarTitleTextAttributes =
    @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    
  
    // Initialize Parse.
    [Parse setApplicationId:@"XRedvfq7gfGVmPCO6KwuDMCBa5Dp2APh7cm93Btb"
                  clientKey:@"Te99tzR4GzvoHn0RLUiMAJayPWjXeuQyVobkQot6"];
    
    [PFLinkedInUtils initializeWithRedirectURL:@"https://www.pushdot.io/callbacks" clientId:@"75uig1plusxeq0" clientSecret:@"So4Svona6HAaQ7vU" state:@"DCEEFWF45453sdffef424" grantedAccess:@[@"r_fullprofile"] presentingViewController:nil];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFImageView class];
    [PFFacebookUtils initializeFacebook];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    
    WelcomeViewController *welcomeViewCtrl = [[WelcomeViewController alloc] init];
    
    PlaneNavigationController *navCtrl = [[PlaneNavigationController alloc] initWithRootViewController:welcomeViewCtrl];
    LeftMenuTableViewController *leftMenuController = [[LeftMenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navCtrl menuViewController:leftMenuController];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlur = NO;
    frostedViewController.delegate = self;
    frostedViewController.blurTintColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
    frostedViewController.blurRadius = 0.0;
    frostedViewController.blurSaturationDeltaFactor = 0.0;
    
    self.window.rootViewController = frostedViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [Fabric with:@[TwitterKit]];
    
    //    [TWTRTweetView appearance].theme = TWTRTweetViewThemeDark;
    //
    //    // Use custom colors
    //    [TWTRTweetView appearance].primaryTextColor = [UIColor yellowColor];
    //    [TWTRTweetView appearance].backgroundColor = [UIColor blueColor];
    //    [TWTRTweetView appearance].linkTextColor = [UIColor redColor];
    
    [self.window makeKeyAndVisible];
    
    
    // Set the position (Top or Bottom)
    
    [[KIProgressViewManager manager] setPosition:KIProgressViewPositionBottom];
    
    // Set the color
    
    [[KIProgressViewManager manager] setColor:[UIColor redColor]];
    
    // Set the gradient
    
    [[KIProgressViewManager manager] setGradientStartColor:[UIColor blackColor]];
    [[KIProgressViewManager manager] setGradientEndColor:[UIColor whiteColor]];
    
    // Currently not supported
    [[KIProgressViewManager manager] setStyle:KIProgressViewStyleRepeated];
    
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self locationManagerStart];
    [FBSDKAppEvents activateApp];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return [[FBSDKApplicationDelegate sharedInstance]application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}
#pragma mark - Push notification methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    //NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    //[PFPush handlePush:userInfo];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] != nil)
    {
        [self performSelector:@selector(refreshRecentView) withObject:nil afterDelay:4.0];
    }
}
- (void)refreshRecentView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}
#pragma mark - Location manager methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManagerStart
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManagerStop
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self.coordinate = newLocation.coordinate;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}

@end
