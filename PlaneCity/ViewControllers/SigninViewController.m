//
//  SigninViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/14/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstant.h"
#import "SigninViewController.h"
#import "public.h"
#import "SignupViewController.h"
#import "ForgotViewController.h"
#import "KIProgressViewManager.h"

@interface SigninViewController ()<UITextFieldDelegate>

//@property (nonatomic, strong)NSString *email;
//@property (nonatomic, strong)NSString *password;

@property (nonatomic, strong)UIView *notify_subView;

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _email_textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.width-40, 40)];
    _email_textField.borderStyle = UITextBorderStyleRoundedRect;
    _email_textField.placeholder = @"Email";
    _email_textField.font = [UIFont systemFontOfSize:14];
    _email_textField.returnKeyType = UIReturnKeyDone;
    _email_textField.tag = 100;
    _email_textField.delegate = self;
    [self.view addSubview:_email_textField];
    
    _password_textField = [[UITextField alloc] initWithFrame:CGRectMake(20, _email_textField.bottom+10, self.view.width-40, 40)];
    _password_textField.borderStyle = UITextBorderStyleRoundedRect;
    _password_textField.placeholder = @"Password";
    _password_textField.font = [UIFont systemFontOfSize:14];
    _password_textField.secureTextEntry = YES;
    _password_textField.returnKeyType = UIReturnKeyDone;
    _password_textField.tag  = 101;
    _password_textField.delegate = self;
    [self.view addSubview:_password_textField];
    
    UIButton *btn_signin = [[UIButton alloc] initWithFrame:CGRectMake(20, _password_textField.bottom+20, self.view.width-40, 40)];
    btn_signin.layer.cornerRadius = 4;
    btn_signin.layer.masksToBounds = YES;
    [btn_signin setTitle:@"Sign In" forState:UIControlStateNormal];
    [btn_signin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_signin addTarget:self action:@selector(btn_signIn_clicked) forControlEvents:UIControlEventTouchUpInside];
    btn_signin.backgroundColor = COLOR_TINT;
    
    [self.view addSubview:btn_signin];
    
    UIButton *btn_forgot = [[UIButton alloc] initWithFrame:CGRectMake(20, btn_signin.bottom+20, 120, 30)];
    [btn_forgot setTitleColor:COLOR_TINT_BLUE forState:UIControlStateNormal];
    [btn_forgot setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    btn_forgot.titleLabel.font = [UIFont systemFontOfSize:14];
    btn_forgot.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn_forgot setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_forgot addTarget:self action:@selector(btn_forgot_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_forgot];
    
    UIButton *btn_join = [[UIButton alloc] initWithFrame:CGRectMake(20, btn_signin.bottom+20, 100, 30)];
    [btn_join setTitleColor:COLOR_TINT_BLUE forState:UIControlStateNormal];
    [btn_join setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn_join.right = self.view.width-20;
    btn_join.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_join setTitle:@"Join Now" forState:UIControlStateNormal];
    btn_join.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn_join addTarget:self action:@selector(btn_join_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_join];
    
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)btn_signIn_clicked {
    _notify_subView = [[UIView alloc]initWithFrame:CGRectMake(25, 200, self.view.width - 50, 100)];
    _notify_subView.backgroundColor = [UIColor blackColor];
    
    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn_close.centerX = _notify_subView.centerX - 25;
    btn_close.top = 10;
    [btn_close setImage:[UIImage imageNamed:@"close_btn_icon.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(dismissNotify) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *notify_content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 35)];
    notify_content.textAlignment = NSTextAlignmentCenter;
    notify_content.textColor = [UIColor whiteColor];
    notify_content.centerX = btn_close.centerX;
    notify_content.top = btn_close.bottom + 10;
    
    [_notify_subView addSubview:notify_content];
    [_notify_subView addSubview:btn_close];
    
    if (![_email_textField.text isEqualToString:@""] && ![_password_textField.text isEqualToString:@""]) {
        //Do anything when register
        [[KIProgressViewManager manager]showProgressOnView:self.view];
        PFQuery *query = [PFUser query];
        [query whereKey:PF_USER_EMAIL equalTo:[_email_textField.text lowercaseString]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] != 0){
                PFUser *user = [objects firstObject];
                [PFUser logInWithUsernameInBackground:user.username password:_password_textField.text block:^(PFUser *user, NSError *error) {
                    if (user){
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:user.username forKey:@"user_name"];
                        [userDefaults setObject:user[PF_USER_PICTURE] forKey:@"user_picture"];
                        [userDefaults synchronize];
                        
                        user[PF_USER_EMLOGGED] = @"YES";
                        [user saveInBackground];
                        
                        [[KIProgressViewManager manager]hideProgressView];
                        
                        AppDelegate *delegator = DELEGATOR_CALL;
                        delegator.isEMLogged = TRUE;
                        
                        [self.navigationController popToRootViewControllerAnimated:NO];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"onWelcomeScreen" object:nil userInfo:nil];
                        
                    }else {
                        [notify_content setText:@"Invalid info"];
                        [self.view addSubview:_notify_subView];
                    }
                }];
            }
            else {
                [notify_content setText:@"Not existed User"];
                [self.view addSubview:_notify_subView];
            }
        }];
    }
    else {
        NSString *notify_str;
        if ([_email_textField.text isEqualToString:@""]) {
            notify_str = @"Please enter your email";
        }
        else if ([_password_textField.text isEqualToString:@""]){
            notify_str = @"Please enter your password";
        }
        [notify_content setText:notify_str];
        [self.view addSubview:_notify_subView];
        _email_textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_email_textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _password_textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_password_textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    }
    _email_textField.enabled = _password_textField.enabled = NO;
    
}

- (void)dismissNotify {
    UIColor *textColor;
    textColor = [_email_textField.text isEqualToString:@""] ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
    _email_textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_email_textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    textColor = [_password_textField.text isEqualToString:@""] ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
    _password_textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_password_textField.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    _email_textField.enabled = _password_textField.enabled = YES;
    _notify_subView.hidden = YES;
}

- (void)btn_close_clicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btn_join_clicked {
    SignupViewController *signupViewCtrl = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:signupViewCtrl animated:YES];
}

- (void)btn_forgot_clicked {
    ForgotViewController *forgotViewCtrl = [[ForgotViewController alloc] init];
    [self.navigationController pushViewController:forgotViewCtrl animated:YES];
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
}
@end