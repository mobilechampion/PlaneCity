//
//  WelcomeViewController.h
//  PlaneCity
//
//  Created by GlennChiu on 5/27/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ViewController.h"

@protocol WelcomeViewControllerDelegate;

@interface WelcomeViewController : ViewController

@property (nonatomic, strong) id<WelcomeViewControllerDelegate>delegate;
@property (nonatomic, strong) NSArray *statuses;

@end

@protocol WelcomeViewControllerDelegate<NSObject>

- (void)authConfirmed;

@end