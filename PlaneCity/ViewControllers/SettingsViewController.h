//
//  SettingsViewController.h
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "public.h"
#import "ViewController.h"

@interface SettingsViewController : ViewController

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic ,strong) NSString *food;
@property (nonatomic, strong) NSString *hobby;
@property (nonatomic, strong) NSString *visitPlace;

@property (nonatomic, strong) NSString *infoText;
@property (nonatomic, assign) NSInteger labelIdx;

@end
