//
//  AppDelegate.h
//  PlaneCity
//
//  Created by GlennChiu on 5/27/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,REFrostedViewControllerDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;


@property (nonatomic, strong) PFUser *currentUser;

@property (nonatomic, assign) BOOL isFBLogged;
@property (nonatomic, assign) BOOL isLILogged;
@property (nonatomic, assign) BOOL isEMLogged;

@end

