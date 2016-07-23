//
//  SignupViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/14/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstant.h"
#import "SignupViewController.h"
#import "public.h"
#import "SigninViewController.h"
#import "ForgotViewController.h"
#import "KIProgressViewManager.h"

@interface SignupViewController () <UITextFieldDelegate>

@property (nonatomic, strong)UITextField *firstname;
@property (nonatomic, strong)UITextField *lastname;
@property (nonatomic, strong)UITextField *email;
@property (nonatomic, strong)UITextField *password;

@property (nonatomic, strong)UIView *notify_subView;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstname = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.width-40, 40)];
    _firstname.textAlignment = NSTextAlignmentLeft;
    _firstname.font = [UIFont systemFontOfSize:14];
    _firstname.borderStyle = UITextBorderStyleRoundedRect;
    _firstname.placeholder = @"First Name";
    _firstname.returnKeyType = UIReturnKeyDone;
    _firstname.tag = 100;
    _firstname.delegate = self;
    
    _lastname = [[UITextField alloc] initWithFrame:CGRectMake(20, _firstname.bottom+10, self.view.width-40, 40)];
    _lastname.textAlignment = NSTextAlignmentLeft;
    _lastname.font = [UIFont systemFontOfSize:14];
    _lastname.borderStyle = UITextBorderStyleRoundedRect;
    _lastname.placeholder = @"Last Name";
    _lastname.returnKeyType = UIReturnKeyDone;
    _lastname.tag = 101;
    _lastname.delegate = self;
    
    _email = [[UITextField alloc] initWithFrame:CGRectMake(20, _lastname.bottom+10, self.view.width-40, 40)];
    _email.textAlignment = NSTextAlignmentLeft;
    _email.font = [UIFont systemFontOfSize:14];
    _email.borderStyle = UITextBorderStyleRoundedRect;
    _email.placeholder = @"Email";
    _email.returnKeyType = UIReturnKeyDone;
    _email.tag = 102;
    _email.delegate = self;
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(20, _email.bottom+10, self.view.width-40, 40)];
    _password.textAlignment = NSTextAlignmentLeft;
    _password.font = [UIFont systemFontOfSize:14];
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.placeholder = @"Password";
    _password.secureTextEntry = YES;
    _password.returnKeyType = UIReturnKeyDone;
    _password.tag = 103;
    _password.delegate = self;
    
    [self.view addSubview:_firstname];
    [self.view addSubview:_lastname];
    [self.view addSubview:_email];
    [self.view addSubview:_password];
    
    UILabel *lbl_des = [[UILabel alloc] initWithFrame:CGRectMake(20, _password.bottom+20, self.view.width-10, 40)];
    lbl_des.font = [UIFont systemFontOfSize:12];
    lbl_des.textColor = [UIColor grayColor];
    lbl_des.numberOfLines = 2;
    lbl_des.text = @"By clicking Join now, you agree to PlaneCity's User Agreement,Privacy Policy and Cookie Policy";
    
    [self.view addSubview:lbl_des];
    
    UIButton *btn_join = [[UIButton alloc] initWithFrame:CGRectMake(20, lbl_des.bottom+20, self.view.width-40, 30)];
    btn_join.layer.cornerRadius = 4;
    btn_join.layer.masksToBounds = YES;
    [btn_join setTitle:@"Join Now" forState:UIControlStateNormal];
    [btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_join setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn_join.backgroundColor = COLOR_TINT;
    [btn_join addTarget:self action:@selector(btn_join_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_join];
    
    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn_close.right = self.view.width-20;
    btn_close.top = 50;
    [btn_close setImage:[UIImage imageNamed:@"close_btn_icon.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(btn_close_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_close];
    
    UILabel *lbl_already = [[UILabel alloc] initWithFrame:CGRectMake(20, btn_join.bottom+10, self.view.width-40, 30)];
    lbl_already.font = [UIFont systemFontOfSize:16];
    lbl_already.textColor = [UIColor grayColor];
    lbl_already.text = @"Already have an account?";
    
    [self.view addSubview:lbl_already];
    
    UIButton *btn_signin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
    [btn_signin setTitle:@"Sign In" forState:UIControlStateNormal];
    [btn_signin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_signin addTarget:self action:@selector(btn_signin_clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_signin setTitleColor:COLOR_TINT_BLUE forState:UIControlStateNormal];
    btn_signin.titleLabel.font = [UIFont systemFontOfSize:12];
    btn_signin.titleLabel.textAlignment = NSTextAlignmentRight;
    btn_signin.right = lbl_already.right;
    btn_signin.top = lbl_already.top+2;
    
    [self.view addSubview:btn_signin];
    
    // Do any additional setup after loading the view.
}
- (void)btn_join_clicked {
    
    _notify_subView = [[UIView alloc]initWithFrame:CGRectMake(25, 250, self.view.width - 50, 100)];
    _notify_subView.backgroundColor = [UIColor blackColor];
    
    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn_close.centerX = _notify_subView.centerX - 25;
    btn_close.top = 10;
    [btn_close setImage:[UIImage imageNamed:@"close_btn_icon.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(dismissNotify) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *notify_content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 35)];
    notify_content.numberOfLines = 2;
    notify_content.textAlignment = NSTextAlignmentCenter;
    notify_content.textColor = [UIColor whiteColor];
    notify_content.centerX = btn_close.centerX;
    notify_content.top = btn_close.bottom + 10;
    
    [_notify_subView addSubview:notify_content];
    [_notify_subView addSubview:btn_close];
    NSLog(@"textfield placeholder %@", _firstname.text);
    if (![_firstname.text isEqualToString:@""] && ![_lastname.text isEqualToString:@""] && ![_email.text isEqualToString:@""] && ![_password.text isEqualToString:@""]) {
        //Do anything when register
        [[KIProgressViewManager manager]showProgressOnView:self.view];

        NSString *em_userName = [_firstname.text stringByAppendingString:@" "];
        em_userName = [em_userName stringByAppendingString:_lastname.text];
        NSString *em_userPicUrl = @"";
        
        //check if existed user
        PFQuery *query = [PFUser query];
        [query whereKey:PF_USER_EMAIL equalTo:[_email.text lowercaseString]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            [[KIProgressViewManager manager]hideProgressView];
            
            if ([objects count] != 0) {             // existed user
                [notify_content setText:@"Already existed user\nPlease use retry"];
                [self.view addSubview:_notify_subView];
                self.firstname.text = self.lastname.text = self.email.text = self.password.text = @"";
                
                PFUser *user = [objects firstObject];
                user.password = _password.text;
                [user signUp];
            }
            else{                                  // new user
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:em_userName forKey:@"user_name"];
                [userDefaults setObject:em_userPicUrl forKey:@"user_picture"];
                [userDefaults synchronize];

                PFUser *user = [PFUser user];
                user.username = em_userName ;
                user.email = [_email.text lowercaseString];
                user.password = _password.text;
                user[PF_USER_FIRSTNAME] = _firstname.text;
                user[PF_USER_LASTNAME] = _lastname.text;
                user[PF_USER_FULLNAME] = em_userName;
                user[PF_USER_FULLNAME_LOWER] = [em_userName lowercaseString];
                user[PF_USER_PICTURE] = em_userPicUrl;
                user[PF_USER_EMLOGGED] = @"YES";
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                }];
                
                AppDelegate *delegator = DELEGATOR_CALL;
                delegator.isEMLogged = TRUE;
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                [[KIProgressViewManager manager]hideProgressView];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"onWelcomeScreen" object:nil userInfo:nil];
            }
        }]; //////
    }
    else {
        NSString *notify_str;
        if ([_firstname.text isEqualToString:@""]) {
            notify_str = @"Please enter your first name";
        }
        else if ([_lastname.text isEqualToString:@""]){
            notify_str = @"Please enter your last name";
        }
        else if ([_email.text isEqualToString:@""]){
            notify_str = @"Please enter your email";
        }
        else if ([_password.text isEqualToString:@""]){
            notify_str = @"Please enter your password";
        }
        [notify_content setText:notify_str];
        [self.view addSubview:_notify_subView];
        
        _firstname.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_firstname.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _lastname.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_lastname.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_email.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        _password.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_password.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    }
    
    _firstname.enabled = _lastname.enabled = _email.enabled = _password.enabled = NO;
    
}

- (void)btn_signin_clicked {
    
    SigninViewController *signinViewCtrl = [[SigninViewController alloc] init];
    [self.navigationController pushViewController:signinViewCtrl animated:YES];
    
}
- (void)btn_close_clicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissNotify {
    [[KIProgressViewManager manager]hideProgressView];
    
    UIColor *textColor;
    textColor = [_firstname.text isEqualToString:@""] ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
    _firstname.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_firstname.placeholder attributes:@{NSForegroundColorAttributeName:textColor}];
    
    textColor = [_lastname.text isEqualToString:@""] ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
    _lastname.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_lastname.placeholder attributes:@{NSForegroundColorAttributeName:textColor}];
    
    textColor = [_email.text isEqualToString:@""] ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
    _email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_email.placeholder attributes:@{NSForegroundColorAttributeName:textColor}];
    
    textColor = [_password.text isEqualToString:@""] ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
    _password.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_password.placeholder attributes:@{NSForegroundColorAttributeName:textColor}];
    
    _firstname.enabled = _lastname.enabled = _email.enabled = _password.enabled = YES;
    _notify_subView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
