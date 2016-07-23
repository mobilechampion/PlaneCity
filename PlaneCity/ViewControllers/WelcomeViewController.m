//
//  WelcomeViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 5/27/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "WelcomeViewController.h"
#import <Accounts/Accounts.h>
#import "STTwitter.h"
#import "public.h"
#import "FeedTableViewCell.h"
#import "PlaneNavigationController.h"
#import "BoardingPassViewController.h"
#import "ReviewViewController.h"
#import "AppConstant.h"
#import "AppDelegate.h"
#import "ProgressHUD.h"
#import "common.h"
#import "push.h"
#import <Twitter/Twitter.h>
#import <TwitterKit/TwitterKit.h>
#import "TTBoardingViewController.h"
#import "PlaneInViewController.h"

#define consumer_key @"PdLBPYUXlhQpt4AguShUIw"
#define consumer_key_secret @"drdhGuKSingTbsDLtYpob4m5b5dn1abf9XXYyZKQzk"

static NSString * const TweetTableReuseIdentifier = @"TweetCell";

typedef void (^accountChooserBlock_t)(ACAccount *account, NSString *errorMessage); // don't bother with NSError for that

@interface WelcomeViewController ()<UIActionSheetDelegate , UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    UITableView *feedTableView;
    
    TWTRTimelineViewController *twtrt;
    
    TTBoardingViewController *ttView;
}
@property (nonatomic, strong) STTwitterAPI *twitter;

@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *iOSAccounts;
@property (nonatomic, strong) accountChooserBlock_t accountChooserBlock;
@property (nonatomic, strong) NSArray *tweets; // Hold all the loaded tweets

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PlaneCity";
    self.accountStore = [[ACAccountStore alloc] init];
    
    ttView = [[TTBoardingViewController alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_alt.png"] style:UIBarButtonItemStylePlain target:(PlaneNavigationController *)self.navigationController action:@selector(showMenu)];
    
    UIBarButtonItem *reviewBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"chat_circle.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(chatBtnClicked)];
    UIBarButtonItem *photoBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"topcamera_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnClicked)];
    
    reviewBtn.imageInsets = UIEdgeInsetsMake(0.0, 0.0, 0,-40);
    self.navigationItem.rightBarButtonItems = @[photoBtn,reviewBtn];
    
    feedTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 8, PHONE_WIDTH-16 , PHONE_HEIGHT-64-16)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[FeedTableViewCell class] forCellReuseIdentifier:@"feedTableViewCellIdentifier"];
        tableView;
    });
    
    twtrt = [[TWTRTimelineViewController alloc] init];
    twtrt.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:twtrt.view];
    
    [[Twitter sharedInstance] logInGuestWithCompletion:^(TWTRGuestSession *guestSession, NSError *error) {
        if (guestSession) {
            
            TWTRAPIClient *APIClient = [[Twitter sharedInstance] APIClient];
            TWTRUserTimelineDataSource *userTimelineDataSource = [[TWTRUserTimelineDataSource alloc] initWithScreenName:@"planecitytweet" APIClient:APIClient];
            twtrt.dataSource = userTimelineDataSource;
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults valueForKey:@"firstload"]) {
        
    } else {
        
        [defaults setValue:[NSNumber numberWithBool:YES] forKey:@"firstload"];
        [defaults synchronize];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window.rootViewController.view addSubview:ttView.view];
        
        UITapGestureRecognizer *tap_ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_back_clicked)];
        ttView.view.userInteractionEnabled = YES;
        [ttView.view addGestureRecognizer:tap_ges];
        
    }
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden =NO;
}

- (void)tap_back_clicked {
    [ttView.view removeFromSuperview];
}
- (void)logoBtnClicked {
    
}
- (void)chatBtnClicked {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    if (userName != nil && ![userName isEqualToString:@""]) {
        PlaneInViewController *planeInViewCtrl = [[PlaneInViewController alloc] init];
        [self.navigationController pushViewController:planeInViewCtrl animated:YES];
    }

}
- (void)photoBtnClicked {
    
    UIActionSheet *sheet_view = [[UIActionSheet alloc] initWithTitle:@"Boarding Pass" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Scan",@"Take a picture and Upload",@"Upload from photo library",@"Email", nil];
    sheet_view.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet_view showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)authWithTwitter {
    
    __weak typeof(self) weakSelf = self;
    
    self.accountChooserBlock = ^(ACAccount *account, NSString *errorMessage) {
        
        NSString *status = nil;
        if(account) {
            status = [NSString stringWithFormat:@"Did select %@", account.username];
            [weakSelf loginWithiOSAccount:account];
            
        } else {
            status = errorMessage;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PlaneCity Notice" message:errorMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alertView show];
            
        }
        
    };
    
    [self chooseAccount];
    
}

- (void)loginWithiOSAccount:(ACAccount *)account {
    
    self.twitter = [STTwitterAPI twitterAPIOSWithAccount:account];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        NSLog(@"%@",username);
        [GlobalPool sharedInstance].fullname = username;
        
        [_twitter getUserTimelineWithScreenName:@"planecitytweet" successBlock:^(NSArray *statuses) {
            
            self.statuses = statuses;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [feedTableView reloadData];
            
        } errorBlock:^(NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PlaneCity Notice" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alertView show];
            
        }];
        
        [_twitter getUserInformationFor:username successBlock:^(NSDictionary *user) {
            NSLog(@"%@",user);
            [GlobalPool sharedInstance].photo_url = [user objectForKey:@"profile_image_url"];
            
        } errorBlock:^(NSError *error) {
            [GlobalPool sharedInstance].photo_url = @"";
        }];
        
        if ([PFUser currentUser] == nil)
        {
            [self actionTwitter];
        }
        
    } errorBlock:^(NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PlaneCity Notice" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        
    }];
    
}

- (void)chooseAccount {
    
    ACAccountType *accountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    ACAccountStoreRequestAccessCompletionHandler accountStoreRequestCompletionHandler = ^(BOOL granted, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if(granted == NO) {
                _accountChooserBlock(nil, @"Acccess not granted.");
                return;
            }
            
            self.iOSAccounts = [_accountStore accountsWithAccountType:accountType];
            
            if([_iOSAccounts count] == 1) {
                ACAccount *account = [_iOSAccounts lastObject];
                _accountChooserBlock(account, nil);
            } else {
                UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Select an account:"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                  destructiveButtonTitle:nil otherButtonTitles:nil];
                for(ACAccount *account in _iOSAccounts) {
                    [as addButtonWithTitle:[NSString stringWithFormat:@"@%@", account.username]];
                }
                [as showInView:self.view.window];
            }
        }];
    };
    
#if TARGET_OS_IPHONE &&  (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
    if (floor(NSFoundationVersionNumber) < NSFoundationVersionNumber_iOS_6_0) {
        [self.accountStore requestAccessToAccountsWithType:accountType
                                     withCompletionHandler:accountStoreRequestCompletionHandler];
    } else {
        [self.accountStore requestAccessToAccountsWithType:accountType
                                                   options:NULL
                                                completion:accountStoreRequestCompletionHandler];
    }
#else
    [self.accountStore requestAccessToAccountsWithType:accountType
                                               options:NULL
                                            completion:accountStoreRequestCompletionHandler];
#endif
    
}

#pragma mark -
#pragma mark UITableView Datasource and Delgate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.statuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = (FeedTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"feedTableViewCellIdentifier"];
    
    if(cell == nil) {
        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"feedTableViewCellIdentifier"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *status = [self.statuses objectAtIndex:indexPath.row];
    
    NSLog(@"%@",status);
    
    NSString *mediaURL = [[status valueForKeyPath:@"entities.media.media_url"] firstObject];
    NSString *text = [status valueForKey:@"text"];
    NSString *screenName = [status valueForKeyPath:@"user.screen_name"];
    NSString *dateString = [status valueForKey:@"created_at"];
    
    if(mediaURL)
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:mediaURL]];
    else {
        cell.photoView.image = nil;
        cell.photoView.backgroundColor = [UIColor clearColor];
    }
    cell.lblContent.text = text;
    cell.lblDate.text = [NSString stringWithFormat:@"@%@ | %@", screenName, dateString];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 178;
}

- (void)actionTwitter
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [ProgressHUD show:@"Signing in..." Interaction:NO];
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error)
     {
         if (user != nil)
         {
             if (user[PF_USER_TWITTERID] == nil)
             {
                 [self processTwitter:user];
             }
             else [self userLoggedIn:user];
         }
         else [ProgressHUD showError:@"Twitter login error."];
     }];
}
- (void)processTwitter:(PFUser *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PF_Twitter *twitter = [PFTwitterUtils twitter];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    user[PF_USER_FULLNAME] = twitter.screenName;
    user[PF_USER_FULLNAME_LOWER] = [twitter.screenName lowercaseString];
    user[PF_USER_TWITTERID] = twitter.userId;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil)
         {
             [PFUser logOut];
             [ProgressHUD showError:error.userInfo[@"error"]];
         }
         else [self userLoggedIn:user];
     }];
}
- (void)userLoggedIn:(PFUser *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    ParsePushUserAssign();
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld",(long)buttonIndex);
    
    if(buttonIndex == [actionSheet cancelButtonIndex]) {
        
    }
    
}

@end
