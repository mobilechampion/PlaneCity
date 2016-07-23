//
//  AuthViewController.h
//  PlaneCity
//
//  Created by GlennChiu on 6/12/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ViewController.h"

@protocol AuthViewControllerDelegate;
@interface AuthViewController : ViewController

@property (nonatomic, strong) id<AuthViewControllerDelegate> delegate;

@end

@protocol AuthViewControllerDelegate<NSObject>

- (void)authConfirmed;

@end