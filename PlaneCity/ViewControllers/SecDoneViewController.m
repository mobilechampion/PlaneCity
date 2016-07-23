//
//  SecDoneViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/15/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "SecDoneViewController.h"
#import "public.h"

@interface SecDoneViewController ()

@end

@implementation SecDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lbl_forgot = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.width-40, 40)];
    lbl_forgot.textAlignment = NSTextAlignmentCenter;
    lbl_forgot.font = [UIFont boldSystemFontOfSize:14];
    lbl_forgot.numberOfLines = 2;
    lbl_forgot.text = @"Great! Now check your email for a link to reset your password.";
    
    [self.view addSubview:lbl_forgot];
    
    UILabel *lbl_des = [[UILabel alloc] initWithFrame:CGRectMake(20, lbl_forgot.bottom+10, self.view.width-40, 30)];
    lbl_des.textAlignment = NSTextAlignmentCenter;
    lbl_des.font = [UIFont systemFontOfSize:11];
    lbl_des.numberOfLines = 2;
    lbl_des.text = @"If you are having problems receiving this link, please contact customer service.";
    
    [self.view addSubview:lbl_des];

    UIButton *btn_check = [[UIButton alloc] initWithFrame:CGRectMake(20, lbl_des.bottom+20, self.view.width-40, 30)];
    btn_check.layer.cornerRadius = 4;
    btn_check.layer.masksToBounds = YES;
    [btn_check setTitle:@"Check Your Email" forState:UIControlStateNormal];
    [btn_check setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_check setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_check addTarget:self action:@selector(btn_check_clicked) forControlEvents:UIControlEventTouchUpInside];
    btn_check.backgroundColor = COLOR_TINT;
    
    [self.view addSubview:btn_check];

    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn_close.right = self.view.width-20;
    btn_close.top = 50;
    [btn_close setImage:[UIImage imageNamed:@"close_btn_icon.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(btn_close_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_close];

    // Do any additional setup after loading the view.
}
- (void)btn_check_clicked {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btn_close_clicked {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
