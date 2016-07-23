//
//  PlaneInViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "PlaneInViewController.h"
#import "public.h"
#import "MemberTableViewCell.h"
#import "AppConstant.h"
#import "ProgressHUD.h"
#import "recent.h"
#import "ChatView.h"

#import "LIALinkedInApplication.h"

@interface PlaneInViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *myBuddies;
    UITableView *memberTableVie;
}

@end

@implementation PlaneInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBuddies];
    
    self.navigationController.navigationBar.topItem.title = @"Back";

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PHONE_WIDTH-100, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(-15, 0, titleView.width, 24)];
    lblAddress.textAlignment = NSTextAlignmentCenter;
    lblAddress.textColor = [UIColor whiteColor];
    lblAddress.font = [UIFont boldSystemFontOfSize:16];
    lblAddress.text = @"SFO  to  DFW";
    
    UILabel *timeAddress = [[UILabel alloc] initWithFrame:CGRectMake(-15, lblAddress.bottom, titleView.width, 16)];
    timeAddress.textAlignment = NSTextAlignmentCenter;
    timeAddress.textColor = [UIColor whiteColor];
    timeAddress.font = [UIFont boldSystemFontOfSize:12];
    timeAddress.text = @"AA193   9:30 AM - 2:30 PM";
    
    [titleView addSubview:lblAddress];
    [titleView addSubview:timeAddress];
    
    self.navigationItem.titleView = titleView;

    UILabel *portLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 160, 25)];
    portLbl.textAlignment = NSTextAlignmentCenter;
    portLbl.textColor = [UIColor blackColor];
    portLbl.font = [UIFont boldSystemFontOfSize:23];
    portLbl.text = @"SFO Airport";
    [self.view addSubview:portLbl];
    
    UIImageView *buddiesView = [[UIImageView alloc] initWithFrame:CGRectMake(10, portLbl.bottom + 10, 40, 30)];
    buddiesView.image = [UIImage imageNamed:@"socialgroup.png"];
    [self.view addSubview:buddiesView];

    UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(PHONE_WIDTH-150, 2, 150, 45)];
    dateLbl.textAlignment = NSTextAlignmentCenter;
    dateLbl.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:113.0/255.0 blue:128.0/255.0 alpha:1.0];
    dateLbl.textColor = [UIColor whiteColor];
    dateLbl.font = [UIFont boldSystemFontOfSize:20];
    dateLbl.text = @"AA193 May 18";
    [self.view addSubview:dateLbl];
    
    UIImageView *airView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 150, PHONE_HEIGHT-84-40)];
    airView.image = [UIImage imageNamed:@"sfo_terminal.png"];
    [self.view addSubview:airView];
    
    memberTableVie = [[UITableView alloc] initWithFrame:CGRectMake(140, 50, PHONE_WIDTH-140 , PHONE_HEIGHT-84)];
    memberTableVie.backgroundColor = [UIColor clearColor];
    memberTableVie.separatorStyle = UITableViewCellSeparatorStyleNone;
    memberTableVie.delegate = self;
    memberTableVie.dataSource = self;
    [memberTableVie registerClass:[MemberTableViewCell class] forCellReuseIdentifier:@"memberTableViewCellIdentifier"];
    
    [self.view addSubview:memberTableVie];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Backend methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadBuddies
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    myBuddies = [[NSMutableArray alloc]init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    
    UILabel *buddiesLbl = [[UILabel alloc] initWithFrame:CGRectMake(50 + 3, 35 + 10, 80, 25)];
    buddiesLbl.textAlignment = NSTextAlignmentCenter;
    buddiesLbl.textColor = [UIColor blackColor];
    buddiesLbl.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:buddiesLbl];

    if (userName != nil && ![userName isEqualToString:@""]) {
        AppDelegate *delegator = DELEGATOR_CALL;
        if (delegator.isFBLogged) {
            self.requiredPermission = @"user_friends";
            if (self.requiredPermission && ![[FBSDKAccessToken currentAccessToken]hasGranted:self.requiredPermission]) {
                
            }else{
                [ProgressHUD show:@"fetching..."];
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/friends?limit=100" parameters:@{@"fields":@"id, name"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError* error)
                 {
                     if (result)
                     {
                         NSArray *_results = [result objectForKey:@"data"];
                         if ([result count] != 0) {
                             for (int i = 0; i < [_results count]; i++) {
                                 NSString *user_name = [[_results objectAtIndex:i] objectForKey:@"name"];
                                 PFQuery *query = [PFUser query];
                                 [query whereKey:PF_USER_USERNAME equalTo:user_name];
                                 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                     if (!error) {
                                         PFUser *user = [objects firstObject];
                                         if ([[user objectForKey:@"emailVerified"]boolValue] == TRUE) {
                                             [myBuddies addObject:user];
                                         }
                                         [memberTableVie reloadData];
                                         buddiesLbl.text = [[NSString stringWithFormat:@"%ld", (long)[myBuddies count]] stringByAppendingString:@" Buddies"];
                                         [ProgressHUD dismiss];
                                     }
                                 }];
                             }
                         }
                     }
                 }];
            }
        }
//        else if (delegator.isLILogged){
////            LIALinkedInHttpClient *_client = [self client];
//            
//            [[self client] getAuthorizationCode:^(NSString * code) {
//                [[self client] getAccessToken:code success:^(NSDictionary *accessTokenData) {
//                    NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
//                    [self requestMeWithToken:accessToken];
//                } failure:^(NSError *error) {
//                }];
//            } cancel:^{
//            } failure:^(NSError *error) {
//                
//            }];
//        }
        else{
            if (delegator.currentUser) {
                [ProgressHUD show:@"fetching..."];

                PFQuery *query1 = [PFQuery queryWithClassName:PF_BLOCKED_CLASS_NAME];
                [query1 whereKey:PF_BLOCKED_USER1 equalTo:delegator.currentUser];
                
                PFQuery *query2 = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
                [query2 whereKey:PF_USER_OBJECTID notEqualTo:delegator.currentUser.objectId];
                [query2 whereKey:PF_USER_OBJECTID doesNotMatchKey:PF_BLOCKED_USERID2 inQuery:query1];
                [query2 orderByAscending:PF_USER_FULLNAME_LOWER];
                [query2 setLimit:1000];
                [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
                 {
                     if (error == nil)
                     {
                         [myBuddies removeAllObjects];
                         [myBuddies addObjectsFromArray:objects];
                         [memberTableVie reloadData];
                         UILabel *buddiesLbl = [[UILabel alloc] initWithFrame:CGRectMake(50 + 3, 35 + 10, 80, 25)];
                         buddiesLbl.textAlignment = NSTextAlignmentCenter;
                         buddiesLbl.textColor = [UIColor blackColor];
                         buddiesLbl.font = [UIFont boldSystemFontOfSize:15];
                         buddiesLbl.text = [[NSString stringWithFormat:@"%ld", (long)[myBuddies count]] stringByAppendingString:@" Buddies"];
                         [self.view addSubview:buddiesLbl];
                         
                         [ProgressHUD dismiss];
                     }
                     else [ProgressHUD showError:@"Network error."];
                 }];
            }
        }
    }
}

- (void)requestMeWithToken:(NSString *)accessToken{
    [[self client] GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation,NSDictionary *result) {
        
        NSLog(@"current user %@", result);
    }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

- (LIALinkedInHttpClient*)client{
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.golden.com.mol/tatiana/" clientId:@"75wbiuwh3x90xy" clientSecret:@"RoAMUW3ZgPEYqpqG" state:@"DCEEFWF45453sdffef424" grantedAccess:@[@"r_fullprofile", @"r_network"]];
    
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [myBuddies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"memberTableViewCellIdentifier";
    
    MemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    PFObject *member = [myBuddies objectAtIndex:indexPath.row];
    NSString *username = member[PF_USER_USERNAME];
    NSString *picUrl = member[PF_USER_PICTURE];
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    cell.lblName.text = username;
    cell.lblStatus.text = member[PF_USER_STATUS];
    cell.socialView.image = [UIImage imageNamed:@"facebook_mark.png"];
    cell.socialView2.image = [UIImage imageNamed:@"linkedin_mark.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *delegator = DELEGATOR_CALL;
    PFUser *user1 = delegator.currentUser;
    PFUser *user2 = [myBuddies objectAtIndex:indexPath.row];
    
    NSString *groupID = StartPrivateChat(user1, user2);
    
    ChatView *chatView = [[ChatView alloc] initWith:groupID];
    chatView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatView animated:YES];
}

@end
