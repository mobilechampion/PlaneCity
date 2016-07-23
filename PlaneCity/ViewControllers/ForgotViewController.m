//
//  ForgotViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/15/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ForgotViewController.h"
#import "public.h"
#import "SecDoneViewController.h"

@interface ForgotViewController (){
    UITextField *email_textField;
}

@end

@implementation ForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lbl_forgot = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.width-40, 30)];
    lbl_forgot.textAlignment = NSTextAlignmentCenter;
    lbl_forgot.font = [UIFont boldSystemFontOfSize:14];
    lbl_forgot.text = @"Changing your password is simple";
    
    [self.view addSubview:lbl_forgot];
    
    UILabel *lbl_des = [[UILabel alloc] initWithFrame:CGRectMake(20, lbl_forgot.bottom+10, self.view.width-40, 30)];
    lbl_des.textAlignment = NSTextAlignmentCenter;
    lbl_des.font = [UIFont systemFontOfSize:11];
    lbl_des.text = @"Please enter your email address to get instructions.";
    
    [self.view addSubview:lbl_des];
    
    email_textField = [[UITextField alloc] initWithFrame:CGRectMake(20, lbl_des.bottom+10, self.view.width-40, 40)];
    email_textField.borderStyle = UITextBorderStyleRoundedRect;
    email_textField.placeholder = @"Email";
    email_textField.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:email_textField];
    
    UIButton *btn_continue = [[UIButton alloc] initWithFrame:CGRectMake(20, email_textField.bottom+20, self.view.width-40, 30)];
    btn_continue.layer.cornerRadius = 4;
    btn_continue.layer.masksToBounds = YES;
    [btn_continue setTitle:@"Continue" forState:UIControlStateNormal];
    [btn_continue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_continue setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_continue addTarget:self action:@selector(btn_continue_clicked) forControlEvents:UIControlEventTouchUpInside];
    btn_continue.backgroundColor = COLOR_TINT;
    
    [self.view addSubview:btn_continue];

    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn_close.right = self.view.width-20;
    btn_close.top = 50;
    [btn_close setImage:[UIImage imageNamed:@"close_btn_icon.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(btn_close_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_close];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btn_close_clicked {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)btn_continue_clicked {
    [PFUser requestPasswordResetForEmailInBackground:[email_textField.text lowercaseString] block:^(BOOL succeeded, NSError *error) {
        if (succeeded){
        }else {
            
        }
    }];
    SecDoneViewController *secDoneCtrl = [[SecDoneViewController alloc] init];
    [self.navigationController pushViewController:secDoneCtrl animated:YES];

}
@end
