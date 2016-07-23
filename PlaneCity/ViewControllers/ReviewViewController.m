//
//  ReviewViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ReviewViewController.h"
#import "PlaneNavigationController.h"
#import "BoardingPassViewController.h"
#import "public.h"
#import "ReviewPostViewController.h"
#import "DownPicker.h"
#import "UIDownPicker.h"
#import "DetailTripViewController.h"

@interface ReviewViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView *contentTableView;
}

@property (strong, nonatomic) DownPicker *toDownPicker;
@property (strong, nonatomic) DownPicker *fromDownPicker;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Reviews";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_alt.png"] style:UIBarButtonItemStylePlain target:(PlaneNavigationController *)self.navigationController action:@selector(showMenu)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"topcamera_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnClicked)];

    contentTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, PHONE_WIDTH , PHONE_HEIGHT-15-64-40)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"contentTableViewCellIdentifier"];
        tableView;
    });
    
    [self.view addSubview:contentTableView];

    contentTableView.tableFooterView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PHONE_WIDTH, 200)];
        
        UILabel *lblDes1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, PHONE_WIDTH-40, 30)];
        lblDes1.textAlignment = NSTextAlignmentLeft;
        lblDes1.text = @"Flight #";
        lblDes1.textColor = COLOR_TINT_BLACK;
        lblDes1.font = [UIFont systemFontOfSize:16];
        [lblDes1 sizeToFit];
        
        [view addSubview:lblDes1];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(lblDes1.right+10, lblDes1.top, 100, 30)];
        textField.textAlignment = NSTextAlignmentLeft;
        textField.text = @"";
        textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        textField.textColor = COLOR_TINT_BLACK;
        textField.font = [UIFont boldSystemFontOfSize:16];
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [COLOR_TINT_BLACK CGColor];
        
        textField.centerY = lblDes1.centerY;
        
        [view addSubview:textField];
        
        UILabel *lblDes2 = [[UILabel alloc] initWithFrame:CGRectMake(textField.right+10, 20, PHONE_WIDTH-40, 30)];
        lblDes2.textAlignment = NSTextAlignmentLeft;
        lblDes2.text = @"(Optional)";
        lblDes2.textColor = COLOR_TINT_BLACK;
        lblDes2.font = [UIFont systemFontOfSize:16];
        
        lblDes2.centerY = textField.centerY;
        
        [view addSubview:lblDes2];
        
        UITextField *toTextField = [[UITextField alloc] initWithFrame:CGRectMake(lblDes1.left, textField.bottom+20, PHONE_WIDTH/3, 30)];
        toTextField.textAlignment = NSTextAlignmentCenter;
        toTextField.placeholder = @"To";
        toTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        toTextField.textColor = COLOR_TINT_BLACK;
        toTextField.font = [UIFont boldSystemFontOfSize:16];
        toTextField.delegate = self;
        toTextField.returnKeyType = UIReturnKeyDone;
        toTextField.layer.borderWidth = 1;
        toTextField.layer.borderColor = [COLOR_TINT_BLACK CGColor];
        
        [view addSubview:toTextField];
        
        self.toDownPicker = [[DownPicker alloc] initWithTextField:toTextField withData:[GlobalPool sharedInstance].airportArray];

        UITextField *fromTextField = [[UITextField alloc] initWithFrame:CGRectMake(toTextField.right+30, textField.bottom+20, PHONE_WIDTH/3+30, 30)];
        fromTextField.textAlignment = NSTextAlignmentCenter;
        fromTextField.placeholder = @"From";
        fromTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        fromTextField.textColor = COLOR_TINT_BLACK;
        fromTextField.font = [UIFont boldSystemFontOfSize:16];
        fromTextField.delegate = self;
        fromTextField.returnKeyType = UIReturnKeyDone;
        fromTextField.layer.borderWidth = 1;
        fromTextField.layer.borderColor = [COLOR_TINT_BLACK CGColor];
        
        [view addSubview:fromTextField];
        
        UIButton *addReviewBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, fromTextField.bottom+20, PHONE_WIDTH-60, 40)];
        [addReviewBtn setTitle:@"Review" forState:UIControlStateNormal];
        addReviewBtn.backgroundColor = COLOR_TINT;
        [addReviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addReviewBtn addTarget:self action:@selector(reviewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:addReviewBtn];

        
        self.fromDownPicker = [[DownPicker alloc] initWithTextField:fromTextField withData:[GlobalPool sharedInstance].airportArray];
        
        view;
    });
    

    // Do any additional setup after loading the view.
}
- (void)reviewBtnClicked {
    ReviewPostViewController *reviewPostCtrl = [[ReviewPostViewController alloc] init];
    [self.navigationController pushViewController:reviewPostCtrl
                                         animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)photoBtnClicked {
    BoardingPassViewController *boardingPassViewCtrl = [[BoardingPassViewController alloc] init];
    [self.navigationController pushViewController:boardingPassViewCtrl animated:YES];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    
    NSArray *titles = @[@"Active Trips", @"Select Airline"];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:145/255.0f green:145/255.0f blue:145/255.0f alpha:1.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = [titles objectAtIndex:sectionIndex];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{

    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
        if([GlobalPool sharedInstance].isLoggedIn) {
            DetailTripViewController *detailTripView = [[DetailTripViewController alloc] init];
            [self.navigationController pushViewController:detailTripView animated:YES];

        }
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        if(![GlobalPool sharedInstance].isLoggedIn)
            return 100;
    }
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(sectionIndex == 0) {
        if([GlobalPool sharedInstance].isLoggedIn)
            return 3;
        else
            return 1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contentTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        if(![GlobalPool sharedInstance].isLoggedIn) {
            
            cell.textLabel.text = @"No active trips.\nScan your boarding pass as soon as you have it,to Enjoy the social connect,Know about your flight and get Rewarded on the go!";
            cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
            cell.textLabel.textColor = COLOR_TINT;
            cell.textLabel.numberOfLines = 5;
            
        } else {
            
            NSArray *titles = @[@"18 May AA193 SFO - DFW", @"19 May AA043 PHY - SJC",@"19 May AA113 MSC - AST"];
            cell.textLabel.text = titles[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];

        }
        
    } else {

        
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    
    return YES;
    
}

@end
