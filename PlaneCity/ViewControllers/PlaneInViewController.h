//
//  PlaneInViewController.h
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface PlaneInViewController : ViewController

@property (nonatomic, strong) FBSDKGraphRequest *request;
@property (nonatomic ,strong) NSString *requiredPermission;

@end
