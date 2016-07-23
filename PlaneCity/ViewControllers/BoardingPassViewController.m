//
//  BoardingPassViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "BoardingPassViewController.h"
#import "PlaneNavigationController.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressLabel.h"
#import "ReviewTableViewCell.h"
#import "ReviewPostViewController.h"

@interface BoardingPassViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    UITableView *reviewTableView;
}
@end

@implementation BoardingPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_alt.png"] style:UIBarButtonItemStylePlain target:(PlaneNavigationController *)self.navigationController action:@selector(showMenu)];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PHONE_WIDTH-100, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(-15, 0, titleView.width, 24)];
    lblAddress.textAlignment = NSTextAlignmentCenter;
    lblAddress.textColor = [UIColor whiteColor];
    lblAddress.font = [UIFont boldSystemFontOfSize:16];
    lblAddress.text = @"SFO  ->  DFW";
    
    UILabel *timeAddress = [[UILabel alloc] initWithFrame:CGRectMake(-15, lblAddress.bottom, titleView.width, 16)];
    timeAddress.textAlignment = NSTextAlignmentCenter;
    timeAddress.textColor = [UIColor whiteColor];
    timeAddress.font = [UIFont boldSystemFontOfSize:12];
    timeAddress.text = @"AA193   9:30 AM - 2:30 PM";
    
    [titleView addSubview:lblAddress];
    [titleView addSubview:timeAddress];
    
    self.navigationItem.titleView = titleView;
    
    // Happy Slider
    UIBarButtonItem *reviewBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(plusBtnClicked)];
    UIBarButtonItem *photoBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"topcamera_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnClicked)];
    
    photoBtn.imageInsets = UIEdgeInsetsMake(0.0, 0.0, 0,-40);
    self.navigationItem.rightBarButtonItems = @[reviewBtn,photoBtn];

    // Happiness
    MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
    newTheme.completedColor = [UIColor colorWithRed:90/255.0 green:212/255.0 blue:39/255.0 alpha:1.0];
    newTheme.incompletedColor = [UIColor colorWithRed:164/255.0 green:231/255.0 blue:134/255.0 alpha:1.0];
    newTheme.centerColor = [UIColor clearColor];
    newTheme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
    newTheme.sliceDividerHidden = YES;
    newTheme.labelColor = COLOR_TINT;
    newTheme.labelShadowColor = [UIColor whiteColor];

    CGRect frame = CGRectMake(20, 40, 80, 80);
    MDRadialProgressView *radialView7 = [[MDRadialProgressView alloc] initWithFrame:frame andTheme:newTheme];
    radialView7.progressTotal = 100;
    radialView7.progressCounter = 78;
    [self.view addSubview:radialView7];

    UILabel *lblHappy = [[UILabel alloc] initWithFrame:CGRectMake(radialView7.left, radialView7.bottom+10, radialView7.width+20, 32)];
    lblHappy.font = [UIFont boldSystemFontOfSize:12];
    lblHappy.textAlignment = NSTextAlignmentCenter;
    lblHappy.text = [NSString stringWithFormat:@"Happiness Index"];
    lblHappy.numberOfLines = 3;
    lblHappy.centerX = radialView7.centerX;
    lblHappy.textColor = [COLOR_TINT colorWithAlphaComponent:0.8];

    [self.view addSubview:lblHappy];
    
    // Gold Coins
    
    UIImageView *coinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    coinImageView.image = [UIImage imageNamed:@"coins_large.png"];
    coinImageView.centerX = PHONE_WIDTH/2-30;
    coinImageView.centerY = radialView7.centerY;
    
    [self.view addSubview:coinImageView];
    
    UILabel *lblGolds = [[UILabel alloc] initWithFrame:CGRectMake(0, radialView7.top, 100, 100)];
    lblGolds.font = [UIFont systemFontOfSize:36];
    lblGolds.textAlignment = NSTextAlignmentLeft;
    lblGolds.text = @"23";
    lblGolds.numberOfLines = 1;
    lblGolds.textColor = COLOR_TINT;
    lblGolds.left = coinImageView.right+10;
    lblGolds.centerY = radialView7.centerY;
    
    [self.view addSubview:lblGolds];
    
    UILabel *lblGolds_Des = [[UILabel alloc] initWithFrame:CGRectMake(coinImageView.left, radialView7.bottom+10, radialView7.width, 32)];
    lblGolds_Des.font = [UIFont boldSystemFontOfSize:12];
    lblGolds_Des.textAlignment = NSTextAlignmentCenter;
    lblGolds_Des.text = [NSString stringWithFormat:@"Gold Coins"];
    lblGolds_Des.numberOfLines = 3;
    lblGolds_Des.textColor = [COLOR_TINT colorWithAlphaComponent:0.8];
    
    [self.view addSubview:lblGolds_Des];

    // Buddies
    
    UIImageView *buddyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [buddyView setImage:[UIImage imageNamed:@"socialgroup.png"]];
    buddyView.centerY = radialView7.centerY;
    buddyView.right = self.view.width - 70;
    
    [self.view addSubview:buddyView];
    
    UILabel *lblBuddy = [[UILabel alloc] initWithFrame:CGRectMake(0, radialView7.top, 100, 100)];
    lblBuddy.font = [UIFont systemFontOfSize:36];
    lblBuddy.textAlignment = NSTextAlignmentLeft;
    lblBuddy.text = @"17";
    lblBuddy.numberOfLines = 1;
    lblBuddy.textColor = COLOR_TINT;
    lblBuddy.left = buddyView.right+5;
    lblBuddy.centerY = buddyView.centerY;
    
    [self.view addSubview:lblBuddy];

    UILabel *lblBuddy_Des = [[UILabel alloc] initWithFrame:CGRectMake(buddyView.left, lblGolds_Des.top, radialView7.width, 32)];
    lblBuddy_Des.font = [UIFont boldSystemFontOfSize:12];
    lblBuddy_Des.textAlignment = NSTextAlignmentCenter;
    lblBuddy_Des.text = [NSString stringWithFormat:@"%@",@"Budies"];
    lblBuddy_Des.numberOfLines = 3;
    lblBuddy_Des.textColor = [COLOR_TINT colorWithAlphaComponent:0.8];
    
    [self.view addSubview:lblBuddy_Des];

    //TableView
    reviewTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, lblBuddy_Des.bottom+15, PHONE_WIDTH-20 , PHONE_HEIGHT-64-lblGolds_Des.bottom-15)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[ReviewTableViewCell class] forCellReuseIdentifier:@"reviewTableViewCellIdentifier"];
        tableView;
    });
    
    [self.view addSubview:reviewTableView];

//    UIButton *addReviewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, reviewTableView.bottom, PHONE_WIDTH, 40)];
//    [addReviewBtn setTitle:@"Add Review" forState:UIControlStateNormal];
//    addReviewBtn.backgroundColor = COLOR_TINT_GREEN;
//    [addReviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [addReviewBtn addTarget:self action:@selector(addReviewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:addReviewBtn];
    // Do any additional setup after loading the view.
}

- (void)addReviewBtnClicked {
    ReviewPostViewController *reviewPostCtrl = [[ReviewPostViewController alloc] init];
    [self.navigationController pushViewController:reviewPostCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plusBtnClicked {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Review",@"Add Smart tip", nil];
    [sheet showInView:self.view];
}

- (void)photoBtnClicked {
    
}

#pragma mark -
#pragma mark UITableView Datasource and Delgate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewTableViewCell *cell = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"reviewTableViewCellIdentifier"];
    
    if(cell == nil) {
        cell = [[ReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reviewTableViewCellIdentifier"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *filename = [NSString stringWithFormat:@"air%d",(int)indexPath.row%3+1];
    
    cell.avatarView.image = [UIImage imageNamed:@"samplePhoto.png"];
    cell.photoView.image = [UIImage imageNamed:filename];
    cell.happyProgressView.progressCounter = 30+(40/(indexPath.row+1));
    cell.nameLbl.text = @"Glenn Chiu";
    cell.descriptionLbl.text = @"I have been using this plane for 5 years, and I have lots of good things, and bad things at the same time forthis....";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190.0;
}

#pragma mark -
#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        ReviewPostViewController *reviewPostViewCtrl = [[ReviewPostViewController alloc] init];
        [self.navigationController pushViewController:reviewPostViewCtrl animated:YES];
        
    }
    
}

@end
