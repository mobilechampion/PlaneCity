//
//  RedeemViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "RedeemViewController.h"
#import "RedeemTableViewCell.h"
#import "public.h"
#import "PlaneNavigationController.h"

@interface RedeemViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *redeemTableView;
}

@end

@implementation RedeemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_alt.png"] style:UIBarButtonItemStylePlain target:(PlaneNavigationController *)self.navigationController action:@selector(showMenu)];
    
    self.navigationItem.title = @"Redeem Coins";
    
    UILabel *lbl_coin = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 40)];
    lbl_coin.textAlignment = NSTextAlignmentCenter;
    lbl_coin.font = [UIFont boldSystemFontOfSize:16];
    lbl_coin.text = @"You have 27 Gold Coins!";
    
    [self.view addSubview:lbl_coin];
    
    redeemTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, lbl_coin.bottom, PHONE_WIDTH , PHONE_HEIGHT-lbl_coin.bottom-64)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[RedeemTableViewCell class] forCellReuseIdentifier:@"redeemTableViewCellIdentifier"];
        tableView;
    });
    
    [self.view addSubview:redeemTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITableView Datasource and Delgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RedeemTableViewCell *cell = (RedeemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"redeemTableViewCellIdentifier"];
    
    if(cell == nil) {
        cell = [[RedeemTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"redeemTableViewCellIdentifier"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    if(indexPath.row % 2 == 0) {
        cell.photoView.image = [UIImage imageNamed:@"beer1.png"];
        cell.lblContent.text = @"TGIF - BEER";
        cell.lblCoins.text = @"80";
    } else {
        cell.photoView.image = [UIImage imageNamed:@"coolpad.png"];
        cell.lblContent.text = @"60% off coupon from Clarie's";
        cell.lblCoins.text = @"800";
    }
    cell.lblContent.numberOfLines = 2;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

@end
