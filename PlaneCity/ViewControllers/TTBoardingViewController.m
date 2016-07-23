//
//  TTBoardingViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/15/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "TTBoardingViewController.h"
#import "public.h"

@interface TTBoardingViewController ()

@end

@implementation TTBoardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UILabel *lbl_des = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, PHONE_WIDTH-40, 80)];
    lbl_des.font = [UIFont systemFontOfSize:18];
    lbl_des.text = @" Scan your boarding Pass to\n connect with your friends and\n earn  rewards";
    lbl_des.numberOfLines = 3;
    lbl_des.layer.borderWidth = 3;
    lbl_des.backgroundColor = [UIColor lightGrayColor];
    lbl_des.layer.borderColor = [COLOR_TINT_BLUE CGColor];
    lbl_des.layer.masksToBounds = YES;
    lbl_des.textColor = [UIColor whiteColor];
    lbl_des.layer.cornerRadius = 8;
    lbl_des.alpha = 0.0;
    [self.view addSubview:lbl_des];
    
    UIImageView *circle_view = [[UIImageView alloc] initWithFrame:CGRectMake(PHONE_WIDTH-48, 22, 40, 40)];
    circle_view.backgroundColor = [UIColor clearColor];
    circle_view.layer.borderColor = [[UIColor whiteColor] CGColor];
    circle_view.layer.borderWidth = 2;
    circle_view.layer.cornerRadius = 20;
    circle_view.layer.masksToBounds = YES;
    
    [self.view addSubview:circle_view];
    
    [UIView animateWithDuration:0.7 animations:^{
        circle_view.alpha = 1.0;
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:0.7 animations:^{
                lbl_des.alpha = 1.0;
            }];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap_back_clicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
