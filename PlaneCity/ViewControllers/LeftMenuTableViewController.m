//
//  LeftMenuTableViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstant.h"
#import "LeftMenuTableViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "WelcomeViewController.h"
#import "PlaneNavigationController.h"
#import "ReviewViewController.h"
#import "SocialViewController.h"
#import "SettingsViewController.h"
#import "RedeemViewController.h"
#import "RecentView.h"
#import "AuthViewController.h"
//#import "UIImageView+WebCache.h"

@interface LeftMenuTableViewController ()<AuthViewControllerDelegate>
{
    UIImageView *photoView;
    UILabel *titleLbl;
    UILabel *descriptionLbl;
}
@end

@implementation LeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)drawTableViewBeforeLogin{
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];

    self.tableView.tableHeaderView = ({
        
        UIView *view_sign = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 180.0f)];
        UIButton *btn_join = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, 250, 30)];
        [btn_join setTitle:@"Join Now / Sign In" forState:UIControlStateNormal];
        [btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_join setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn_join addTarget:self action:@selector(btn_join_clicked) forControlEvents:UIControlEventTouchUpInside];
        btn_join.titleLabel.font = [UIFont systemFontOfSize:16];
        [view_sign addSubview:btn_join];
        
        UILabel *lbl_join_des = [[UILabel alloc] initWithFrame:CGRectMake(0, btn_join.bottom, 250, 40)];
        lbl_join_des.numberOfLines = 2;
        lbl_join_des.textAlignment = NSTextAlignmentCenter;
        lbl_join_des.font = [UIFont italicSystemFontOfSize:12];
        lbl_join_des.textColor = [UIColor colorWithRed:255.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1.0];
        lbl_join_des.text = @"Enjoy with social connect,Know your\nflight and get rewarded on the go!";
        [view_sign addSubview:lbl_join_des];
        
        view_sign;
    });
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self drawTableViewBeforeLogin];
    [self authConfirmed];
}

- (void)btn_join_clicked {
    
    AuthViewController *auth_view = [[AuthViewController alloc] init];
    PlaneNavigationController *navCtrl = [[PlaneNavigationController alloc] initWithRootViewController:auth_view];
    auth_view.delegate = self;
    [self presentViewController:navCtrl animated:YES completion:nil];
}
- (void)authConfirmed {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    NSString *userPicUrl = [userDefaults objectForKey:@"user_picture"];
    
    if (userName != nil && ![userName isEqualToString:@""]){
        PFQuery *query = [PFUser query];
        [query whereKey:PF_USER_USERNAME equalTo:userName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (![objects count] == 0) {

                AppDelegate *delegator = DELEGATOR_CALL;
                delegator.currentUser = [objects firstObject];
                if ([[[objects firstObject]objectForKey:PF_USER_FBLOGGED] isEqualToString:@"YES"]) delegator.isFBLogged = TRUE;
                if ([[[objects firstObject]objectForKey:PF_USER_LILOGGED] isEqualToString:@"YES"]) delegator.isLILogged = TRUE;
                if ([[[objects firstObject]objectForKey:PF_USER_EMLOGGED] isEqualToString:@"YES"]) delegator.isEMLogged = TRUE;
            }
        }];
        self.tableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 180.0f)];
            
            photoView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 60, 80, 80)];
            if (userPicUrl == nil || [userPicUrl isEqualToString:@""]){
                photoView.image = [UIImage imageNamed:@"icon-user-default@2x.png"];
            }else{
                [photoView sd_setImageWithURL:[NSURL URLWithString:userPicUrl]];
            }
            photoView.layer.cornerRadius = photoView.layer.frame.size.height/2;
            photoView.layer.masksToBounds = YES;
            photoView.layer.borderWidth = 0;

            titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 24)];
            titleLbl.text = userName;
            titleLbl.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
            titleLbl.backgroundColor = [UIColor clearColor];
            titleLbl.textColor = [UIColor whiteColor];
            [titleLbl sizeToFit];
            titleLbl.left = photoView.right+10;
            titleLbl.bottom = photoView.bottom-10;
            
            descriptionLbl = [[UILabel alloc] initWithFrame:CGRectMake(photoView.left,photoView.bottom+10, 280, 40)];
            descriptionLbl.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
            descriptionLbl.backgroundColor = [UIColor clearColor];
            descriptionLbl.numberOfLines = 3;
            [descriptionLbl setText:[userDefaults objectForKey:@"user_status"]];
            descriptionLbl.textColor = [UIColor whiteColor];
            descriptionLbl.textAlignment = NSTextAlignmentCenter;
            [descriptionLbl sizeToFit];
            
            [view addSubview:photoView];
            [view addSubview:titleLbl];
            [view addSubview:descriptionLbl];
            
            view;
        });
    }
    [self.tableView reloadData];

}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        WelcomeViewController *homeViewController = [[WelcomeViewController alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
        
    } else if(indexPath.section == 0 && indexPath.row == 1){

        ReviewViewController *reviewController = [[ReviewViewController alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:reviewController];
        self.frostedViewController.contentViewController = navigationController;

    } else if(indexPath.section == 0 && indexPath.row == 2){
        
        SocialViewController *socialViewCtrl = [[SocialViewController alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:socialViewCtrl];
        self.frostedViewController.contentViewController = navigationController;

    } else if(indexPath.section == 0 && indexPath.row == 5){
        
        SettingsViewController *settingViewCtrl = [[SettingsViewController alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:settingViewCtrl];
        self.frostedViewController.contentViewController = navigationController;

    } else if(indexPath.section == 0 && indexPath.row == 3) {
        
        RedeemViewController *redeemViewCtrl = [[RedeemViewController alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:redeemViewCtrl];
        self.frostedViewController.contentViewController = navigationController;

    } else if(indexPath.section == 0 && indexPath.row == 4) {
        RecentView *recentView = [[RecentView alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:recentView];
        self.frostedViewController.contentViewController = navigationController;
    }else if(indexPath.section == 0 && indexPath.row == 6) {
        [GlobalPool sharedInstance].isLoggedIn = FALSE;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"" forKey:@"user_name"];
        [userDefaults setObject:@"" forKey:@"user_status"];
        
        AppDelegate *delegator = DELEGATOR_CALL;
        delegator.isFBLogged = delegator.isLILogged = FALSE;
        
        [self drawTableViewBeforeLogin];
        
        WelcomeViewController *homeViewController = [[WelcomeViewController alloc] init];
        PlaneNavigationController *navigationController = [[PlaneNavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    if (userName != nil && ![userName isEqualToString:@""])
        return 7;
    else
        return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *titles = @[@"Home", @"Reviews", @"Social Connect", @"Redeem", @"My Buddies", @"Settings", @"Log Out"];
    NSArray *images = @[@"homeIcon",@"reviewIcon",@"socialIcon",@"redeemIcon",@"chatIcon",@"settingsIcon", @"logoutIcon"];
    
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [[UIImage imageNamed:[images objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.imageView setTintColor:[UIColor whiteColor]];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

@end
