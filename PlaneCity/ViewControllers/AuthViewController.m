//
//  AuthViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/12/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstant.h"
#import "AuthViewController.h"
#import "public.h"
#import "SigninViewController.h"
#import "SignupViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LinkedInHelper.h"
#import "KIProgressViewManager.h"

@interface AuthViewController (){
    UIView * _alert_subView;
    
    NSString * username;
    NSString * picurl;
    NSString * email;
}

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    BOOL li_status = [userDef boolForKey:@"linkedin_logged"];
    if (!li_status) {
        [self btn_li_clicked];
    }
    
    self.title = @"Signin";
    
    UIButton *btn_li = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, self.view.width-100, 40)];
    [btn_li setImage:[UIImage imageNamed:@"li_connect_btn.png"] forState:UIControlStateNormal];
    [btn_li addTarget:self action:@selector(btn_li_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_li];

    UIButton *btn_fb = [[UIButton alloc] initWithFrame:CGRectMake(50, btn_li.bottom+10, self.view.width-100, 40)];
    [btn_fb setImage:[UIImage imageNamed:@"fb_connect_btn.png"] forState:UIControlStateNormal];
    [btn_fb addTarget:self action:@selector(btn_fb_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_fb];
    
    UIButton *btn_email = [[UIButton alloc] initWithFrame:CGRectMake(50, btn_fb.bottom+10, self.view.width-100, 40)];
    [btn_email addTarget:self action:@selector(btn_email_clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_email setImage:[UIImage imageNamed:@"em_connect_btn.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn_email];
    
    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    btn_close.right = self.view.width-20;
    btn_close.top = 50;
    [btn_close setImage:[UIImage imageNamed:@"close_btn_icon.png"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(btn_close_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_close];
    
    UILabel *lblAlready = [[UILabel alloc] initWithFrame:CGRectMake(60, btn_email.bottom+10, self.view.width-100, 24)];
    lblAlready.textAlignment = NSTextAlignmentLeft;
    lblAlready.font = [UIFont systemFontOfSize:12];
    lblAlready.textColor = [UIColor darkGrayColor];
    lblAlready.text = @"Already have an account?";
    [lblAlready sizeToFit];
    [self.view addSubview:lblAlready];
    
    UIButton *btn_signin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
    [btn_signin setTitle:@"Sign In" forState:UIControlStateNormal];
    [btn_signin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_signin addTarget:self action:@selector(btn_signin_clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn_signin setTitleColor:COLOR_TINT_BLUE forState:UIControlStateNormal];
    btn_signin.titleLabel.font = [UIFont systemFontOfSize:12];
    btn_signin.left = lblAlready.right;
    btn_signin.top = lblAlready.top - 5;
    
    [self.view addSubview:btn_signin];
    // Do any additional setup after loading the view.
    if ([FBSDKAccessToken currentAccessToken]) {
        [btn_fb setImage:[UIImage imageNamed:@"fb_continue_btn@2x copy.png"] forState:UIControlStateNormal];
    }
    
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    if (linkedIn.isValidToken) {
        [btn_li setImage:[UIImage imageNamed:@"li_continue_btn@2x.png"] forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onWelcome) name:@"onWelcomeScreen" object:nil];
}

- (void) onWelcome
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)btn_signin_clicked {
    
    SigninViewController *signin_viewCtrl = [[SigninViewController alloc] init];
    [self.navigationController pushViewController:signin_viewCtrl animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn_close_clicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)btn_fb_clicked {
    [[KIProgressViewManager manager]showProgressOnView:self.view];

    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

        if (error) {
            
        } else if (result.isCancelled) {
            
        } else {
            
            [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me?fields=name,first_name,last_name,email,picture" parameters:nil]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                
                NSString *fb_firstName    = [result objectForKey:@"first_name"];
                NSString *fb_lastName     = [result objectForKey:@"last_name"];
                username = [result objectForKey:@"name"];
                picurl   = [[[result objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"];
                email    = [result objectForKey:@"email"];
                
                //check if existed user
                PFQuery *query = [PFUser query];
                [query whereKey:PF_USER_EMAIL equalTo:email];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if ([objects count] != 0) {             // existed user
                        PFObject *object = [objects firstObject];
                        [object setObject:@"YES" forKey:PF_USER_FBLOGGED];
                        [object saveInBackground];
                    }
                    else{                                  // new user
                        PFUser *user = [PFUser user];
                        user.username = username;
                        user.email = email;
                        user.password = @"";
                        user[PF_USER_FIRSTNAME] = fb_firstName;
                        user[PF_USER_LASTNAME] = fb_lastName;
                        user[PF_USER_FULLNAME] = username;
                        user[PF_USER_FULLNAME_LOWER] = [username lowercaseString];
                        user[PF_USER_PICTURE] = picurl;
                        user[PF_USER_FBLOGGED] = @"YES";
                        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        }];
                    }
                    
                    // email verify
                    
                    BOOL interVal = [[[objects firstObject]objectForKey:@"emailVerified"]boolValue];
                    if (interVal == FALSE) {
                        [self emailVerifyCatch];
                        
                    }else {
                        AppDelegate *delegator = DELEGATOR_CALL;
                        delegator.isFBLogged = TRUE;
                        
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:username forKey:@"user_name"];
                        [userDefaults setObject:picurl forKey:@"user_picture"];
                        [userDefaults synchronize];
                        [self.navigationController dismissViewControllerAnimated:YES completion:^{
                            if(self.delegate && [self.delegate respondsToSelector:@selector(authConfirmed)]){
                                
                                [self.delegate authConfirmed];
                                [GlobalPool sharedInstance].isLoggedIn = YES;
                            }
                        }];
                    }
                }];
            }];
        }
    }];
}

- (void)emailVerifyCatch {
    _alert_subView = [[UIView alloc]initWithFrame:CGRectMake(25, 250, self.view.width - 50, 100)];
    _alert_subView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *_alert_content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    _alert_content.numberOfLines = 2;
    _alert_content.textAlignment = NSTextAlignmentCenter;
    _alert_content.font = [UIFont systemFontOfSize:11.0f];
    [_alert_content setText:@"You should verify your email\nPlease check your email before login"];
    _alert_content.centerX = _alert_subView.centerX - 25;
    _alert_content.top = _alert_subView.height / 2 - 40;
    
    
    UIButton *btn_close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [btn_close setTitle:@"OK" forState:UIControlStateNormal];
    [btn_close setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn_close.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    btn_close.centerX = _alert_content.centerX;
    btn_close.top = _alert_content.bottom + 10;
    [btn_close addTarget:self action:@selector(checkedEmail) forControlEvents:UIControlEventTouchUpInside];
    
    [_alert_subView addSubview:_alert_content];
    [_alert_subView addSubview:btn_close];
    
    [self.view addSubview:_alert_subView];
}

- (void)checkedEmail{
    _alert_subView.hidden = YES;
}

- (void)btn_email_clicked {
    SignupViewController *signup_view = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:signup_view animated:YES];
}

- (void)btn_li_clicked {
    [[KIProgressViewManager manager]showProgressOnView:self.view];

    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    
    if (linkedIn.isValidToken) {
        linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@", formatted_name, picture_url];
        [linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
            
            PFQuery *query = [PFUser query];
            [query whereKey:PF_USER_USERNAME equalTo:[userInfo objectForKey:@"formattedName"]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                BOOL interVal = [[[objects firstObject]objectForKey:@"emailVerified"]boolValue];
                if (interVal == FALSE) {
                    [self emailVerifyCatch];
                    
                }else {
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:[userInfo objectForKey:@"formattedName"] forKey:@"user_name"];
                    [userDefaults setObject:[userInfo objectForKey:@"pictureUrl"] forKey:@"user_picture"];
                    [userDefaults setBool:YES forKey:@"linkedin_logged"];
                    [userDefaults synchronize];
                    
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                        if(self.delegate && [self.delegate respondsToSelector:@selector(authConfirmed)]){
                            [[KIProgressViewManager manager]hideProgressView];
                            [self.delegate authConfirmed];
                            [GlobalPool sharedInstance].isLoggedIn = YES;
                        }
                    }];
                }
                [[objects firstObject] setObject:@"YES" forKey:PF_USER_LILOGGED];
                [[objects firstObject] saveInBackground];
            }];
        } failUserInfo:^(NSError *error) {
            NSLog(@"error : %@", error.userInfo.description);
        }];
    } else {
        
        NSArray *permissions = @[@(BasicProfile),
                                 @(EmailAddress)];
        linkedIn.showActivityIndicator = YES;
        [linkedIn requestMeWithSenderViewController:self
                                           clientId:@"75wbiuwh3x90xy"
                                       clientSecret:@"RoAMUW3ZgPEYqpqG"
                                        redirectUrl:@"http://www.golden.com.mol/tatiana/"
                                        permissions:permissions
                                    successUserInfo:^(NSDictionary *userInfo) {
                                       [[KIProgressViewManager manager]hideProgressView];
                                        
                                        // Whole User Info
                                        NSString *li_firstName = [userInfo objectForKey:@"firstName"];
                                        NSString *li_lastName = [userInfo objectForKey:@"lastName"];
                                        username = [userInfo objectForKey:@"formattedName"];
                                        picurl = [userInfo objectForKey:@"pictureUrl"];
                                        email = [userInfo objectForKey:@"emailAddress"];
                                        
                                        //check if existed user
                                        PFQuery *query = [PFUser query];
                                        [query whereKey:PF_USER_EMAIL equalTo:email];
                                        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                            if ([objects count] != 0) {             // existed user
                                                PFObject *object = [objects firstObject];
                                                [object setObject:@"YES" forKey:PF_USER_LILOGGED];
                                                [object saveInBackground];
                                            }
                                            else{                                  // new user
                                                PFUser *user = [PFUser user];
                                                user.username = username;
                                                user.email = email;
                                                user.password = @"";
                                                user[PF_USER_FIRSTNAME] = li_firstName;
                                                user[PF_USER_LASTNAME] = li_lastName;
                                                user[PF_USER_FULLNAME] = username;
                                                user[PF_USER_FULLNAME_LOWER] = [username lowercaseString];
                                                user[PF_USER_PICTURE] = picurl;
                                                user[PF_USER_LILOGGED] = @"YES";
                                                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                }];
                                            }
                                            // email verify
                                            
                                            BOOL interVal = [[[objects firstObject]objectForKey:@"emailVerified"]boolValue];
                                            if (interVal == FALSE) {
                                                [self emailVerifyCatch];
                                                
                                            }else {
                                                AppDelegate *delegator = DELEGATOR_CALL;
                                                delegator.isLILogged = TRUE;
                                                
                                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                [userDefaults setObject:username forKey:@"user_name"];
                                                [userDefaults setObject:picurl forKey:@"user_picture"];
                                                [userDefaults synchronize];
                                                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                                                    if(self.delegate && [self.delegate respondsToSelector:@selector(authConfirmed)]){
                                                        
                                                        [self.delegate authConfirmed];
                                                        [GlobalPool sharedInstance].isLoggedIn = YES;
                                                    }
                                                }];
                                            }
                                        }];
                                    }
                                  failUserInfoBlock:^(NSError *error) {
                                      NSLog(@"error : %@", error.userInfo.description);
                                  }
         ];
    }
}

@end
