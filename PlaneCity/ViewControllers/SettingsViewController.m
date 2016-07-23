//
//  SettingsViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstant.h"
#import "SettingsViewController.h"
#import "PlaneNavigationController.h"
#import <CoreText/CoreText.h>
#import "TextEditViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView *photo_view;
    UITableView *contentTableView;
    
    UITextField *status_textField;
    
    UILabel *first_lbl;
    UILabel *last_lbl;
    UILabel *email_lbl;
    UILabel *address_lbl;
    UILabel *food_lbl;
    UILabel *hobby_lbl;
    UILabel *visit_lbl;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_alt.png"] style:UIBarButtonItemStylePlain target:(PlaneNavigationController *)self.navigationController action:@selector(showMenu)];
    
    self.isEdit = FALSE;
    status_textField.enabled = FALSE;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(saveBtnClicked)];
    
    self.navigationItem.title = @"Settings";

    contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    contentTableView.backgroundColor = [UIColor whiteColor];
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    contentTableView.tableFooterView = [UIView new];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"contentTableViewCellIdentifier"];
    
    [self.view addSubview:contentTableView];
    
    photo_view = [[UIImageView alloc] initWithFrame:CGRectMake(PHONE_WIDTH-100, 5, 60, 60)];

    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotify:) name:@"infoEdition" object:nil];
}

- (void) onNotify:(NSNotification*)notify
{
    NSDictionary *dict = (NSDictionary*)notify.object;
    
    NSLog(@"%@", dict);
    _infoText = [dict objectForKey:@"text"];
    _labelIdx = [[dict objectForKey:@"val"] integerValue];
    switch (_labelIdx) {
        case 0:
            first_lbl.text = _firstName = _infoText;
            break;
        case 1:
            last_lbl.text = _lastName = _infoText;
            break;
        case 2:
            email_lbl.text = _email = _infoText;
            break;
        case 3:
            address_lbl.text = _address = _infoText;
            break;
        case 4:
            food_lbl.text = _food = _infoText;
            break;
        case 5:
            hobby_lbl.text = _hobby = _infoText;
            break;
        case 6:
            visit_lbl.text = _visitPlace = _infoText;
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveBtnClicked {
    AppDelegate *delegator = DELEGATOR_CALL;
    if (delegator.isFBLogged || delegator.isLILogged || delegator.isEMLogged) {
        if (self.isEdit){
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(saveBtnClicked)];
            status_textField.enabled = FALSE;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userName = [userDefaults objectForKey:@"user_name"];
            [userDefaults setObject:status_textField.text forKey:@"user_status"];
            [userDefaults synchronize];
            
            PFQuery *query = [PFUser query];
            [query whereKey:PF_USER_USERNAME equalTo:userName];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if ([objects count] != 0) {             // existed user
                    PFObject *object = [objects firstObject];
                    
                    [object setObject:status_textField.text forKey:PF_USER_STATUS];
                    [object setObject:_firstName forKey:PF_USER_FIRSTNAME];
                    [object setObject:_lastName forKey:PF_USER_LASTNAME];
                    [object setObject:_email forKey:PF_USER_EMAIL];
                    if (_address != nil)    [object setObject:_address forKey:PF_USER_ADDRESS];
                    if (_hobby != nil)   [object setObject:_hobby forKey:PF_USER_HOBBY];
                    if (_food != nil)   [object setObject:_food forKey:PF_USER_FOOD];
                    if (_visitPlace != nil)   [object setObject:_visitPlace forKey:PF_USER_VISITPLACE];
                    
                    [object saveInBackground];
                }
            }];
            self.isEdit = FALSE;
        }
        else {
            status_textField.enabled = TRUE;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveBtnClicked)];
            self.isEdit = TRUE;
        }
    }
}

#pragma mark -
#pragma mark UITableView Delegate and Datasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if(sectionIndex == 0) {
        return nil;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
        return view;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if(sectionIndex == 0)
        return 10;
    else
        return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isEdit) {
        if(indexPath.section == 0 && indexPath.row == 0) {
            
            UIActionSheet *sheet_view = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Upload Existing Photo", nil];
            [sheet_view showInView:self.view];
            
        } else if(indexPath.section == 1 || indexPath.section == 2) {
            TextEditViewController *textEditView = [[TextEditViewController alloc] init];
            if (indexPath.section == 1) {
                switch (indexPath.row) {
                    case 0:{
                        _infoText = self.firstName;
                        _labelIdx = 0;
                    }
                        break;
                    case 1:{
                        _infoText = self.lastName;
                        _labelIdx = 1;
                    }
                        break;
                    case 2:{
                        _infoText = self.email;
                        _labelIdx = 2;
                    }
                        break;
                    case 3:{
                        _infoText = self.address;
                        _labelIdx = 3;
                    }
                        break;
                }
            }
            else {
                switch (indexPath.row) {
                    case 0:{
                        _infoText = self.food;
                        _labelIdx = 4;
                    }
                        break;
                    case 1:{
                        _infoText = self.hobby;
                        _labelIdx = 5;
                    }
                        break;
                    case 2:{
                        _infoText = self.visitPlace;
                        _labelIdx = 6;
                    }
                        break;
                }
            }
            textEditView.text = _infoText;
            textEditView.interVal = _labelIdx;
            [self.navigationController pushViewController:textEditView animated:YES];
        }
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        if(indexPath.row == 0)
            return 65;
        else {
            AppDelegate *delegator = DELEGATOR_CALL;
            if (delegator.isFBLogged && delegator.isLILogged) return 28;
            else return 80;
        }
    }
    else
        return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(sectionIndex == 0) {
        return 2;
    } else if(sectionIndex == 1) {
        return 4;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contentTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.textLabel.text = @"";
    
    AppDelegate *delegator = DELEGATOR_CALL;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = @"Profile Picture";
            cell.textLabel.textColor = [UIColor blackColor];
            if (userName != nil && ![userName isEqualToString:@""] && delegator.isFBLogged) {
                UIButton *btn_facebook = [[UIButton alloc] initWithFrame:CGRectMake(50, cell.bottom - 37, 32, 32)];
                [btn_facebook setImage:[UIImage imageNamed:@"facebook_mark.png"] forState:UIControlStateNormal];
                
                [cell.contentView addSubview:btn_facebook];
            }
            if (userName != nil && ![userName isEqualToString:@""] && delegator.isLILogged){
                UIButton *btn_linkedin = [[UIButton alloc] initWithFrame:CGRectMake(100, cell.bottom - 37, 32, 32)];
                [btn_linkedin setImage:[UIImage imageNamed:@"linkedin_mark.png"] forState:UIControlStateNormal];
                
                [cell.contentView addSubview:btn_linkedin];
            }            
            if (userName == nil || [userName isEqualToString:@""]){
                photo_view.image = [UIImage imageNamed:@"icon-user-default.png"];
            }
            else {
                NSString *userPicUrl = [userDefaults objectForKey:@"user_picture"];

                PFQuery *query = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
                [query whereKey:PF_USER_USERNAME equalTo:userName];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (userPicUrl == nil || [userPicUrl isEqualToString:@""]){
                        photo_view.image = [UIImage imageNamed:@"icon-user-default@2x.png"];
                    }else{
                        [photo_view sd_setImageWithURL:[NSURL URLWithString:userPicUrl]];
                    }
                    
                    self.firstName = [[objects firstObject]objectForKey:PF_USER_FIRSTNAME];
                    first_lbl.text = self.firstName;

                    self.lastName = [[objects firstObject]objectForKey:PF_USER_LASTNAME];
                    last_lbl.text = self.lastName;

                    self.email = [[objects firstObject]objectForKey:PF_USER_EMAIL];
                    email_lbl.text = self.email;
                    
                    self.status = [[objects firstObject]objectForKey:PF_USER_STATUS];
                    status_textField.text = self.status;
                    
                    self.address = [[objects firstObject]objectForKey:PF_USER_ADDRESS];
                    address_lbl.text = self.address;

                    self.food = [[objects firstObject] objectForKey:PF_USER_FOOD];
                    food_lbl.text = self.food;

                    self.hobby = [[objects firstObject] objectForKey:PF_USER_HOBBY];
                    hobby_lbl.text = self.hobby;

                    self.visitPlace = [[objects firstObject] objectForKey:PF_USER_VISITPLACE];
                    visit_lbl.text = self.visitPlace;

                }];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            [cell.contentView addSubview:photo_view];
            
        } else {
            status_textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, PHONE_WIDTH-20, 28)];
            status_textField.textAlignment = NSTextAlignmentLeft;
            status_textField.font = [UIFont systemFontOfSize:13];
            status_textField.borderStyle = UITextBorderStyleRoundedRect;
            status_textField.returnKeyType = UIReturnKeyDone;
            status_textField.delegate = self;
            status_textField.text = self.status;
            status_textField.placeholder = @"Status";
            status_textField.enabled = FALSE;
            [cell.contentView addSubview:status_textField];
            
            if (delegator.isFBLogged && delegator.isLILogged){
                
            }
            else{
                UILabel *lbl_friend = [[UILabel alloc] initWithFrame:CGRectMake(13, status_textField.bottom+5, PHONE_WIDTH-21, 18)];
                lbl_friend.font = [UIFont systemFontOfSize:14];
                lbl_friend.textColor = [UIColor blackColor];
                lbl_friend.text = @" Find Friends: Connect to";
                
                [cell.contentView addSubview:lbl_friend];
                if (!delegator.isFBLogged && !delegator.isLILogged) {
                    UIButton *btn_facebook = [[UIButton alloc] initWithFrame:CGRectMake(100, lbl_friend.bottom+5, 32, 32)];
                    [btn_facebook setImage:[UIImage imageNamed:@"facebook_mark.png"] forState:UIControlStateNormal];
                    
                    UIButton *btn_linkedin = [[UIButton alloc] initWithFrame:CGRectMake(182, lbl_friend.bottom+5, 32, 32)];
                    [btn_linkedin setImage:[UIImage imageNamed:@"linkedin_mark.png"] forState:UIControlStateNormal];
                    
                    [cell.contentView addSubview:btn_linkedin];
                    
                    [cell.contentView addSubview:btn_facebook];
                }
                else if (!delegator.isFBLogged && delegator.isLILogged){
                    UIButton *btn_facebook = [[UIButton alloc] initWithFrame:CGRectMake(141, lbl_friend.bottom+5, 32, 32)];
                    [btn_facebook setImage:[UIImage imageNamed:@"facebook_mark.png"] forState:UIControlStateNormal];
                    
                    [cell.contentView addSubview:btn_facebook];
                }
                else if (delegator.isFBLogged && !delegator.isLILogged) {
                    UIButton *btn_linkedin = [[UIButton alloc] initWithFrame:CGRectMake(141, lbl_friend.bottom+5, 32, 32)];
                    [btn_linkedin setImage:[UIImage imageNamed:@"linkedin_mark.png"] forState:UIControlStateNormal];
                    
                    [cell.contentView addSubview:btn_linkedin];
                }
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    } else if(indexPath.section == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (!delegator.isFBLogged && !delegator.isLILogged) {
            
        }
        UIImageView *sepLineView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43, PHONE_WIDTH-10, 0.5)];
        sepLineView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        
        [cell addSubview:sepLineView];
        
        if(indexPath.row == 0) {
            
            cell.textLabel.text = @"First Name";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            first_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            first_lbl.font = [UIFont systemFontOfSize:14];
            first_lbl.text = self.firstName;
            first_lbl.textAlignment = NSTextAlignmentRight;
            first_lbl.textColor = COLOR_TINE_BLACK_GREEN;
            
            [cell.contentView addSubview:first_lbl];
            
        } else if(indexPath.row == 1) {
            
            cell.textLabel.text = @"Last Name";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            
            last_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            last_lbl.font = [UIFont systemFontOfSize:14];
            last_lbl.text = self.lastName;
            last_lbl.textAlignment = NSTextAlignmentRight;
            last_lbl.textColor = COLOR_TINE_BLACK_GREEN;
            [cell.contentView addSubview:last_lbl];
            
            
        } else if(indexPath.row == 2) {
            cell.textLabel.text = @"Email";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            
            email_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            email_lbl.font = [UIFont systemFontOfSize:14];
            email_lbl.text = self.email;
            email_lbl.textAlignment = NSTextAlignmentRight;
            email_lbl.textColor = COLOR_TINT_BLUE;
            if (email_lbl.text != nil) {
                NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:email_lbl.text];
                [attrString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                                   value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                                   range:(NSRange){0,[attrString length]}];
                email_lbl.attributedText = attrString;
            }
        
            [cell.contentView addSubview:email_lbl];
            
        } else if(indexPath.row == 3) {
            
            cell.textLabel.text = @"Address";
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            address_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            address_lbl.font = [UIFont systemFontOfSize:14];
            address_lbl.text = self.address;
            address_lbl.textAlignment = NSTextAlignmentRight;
            address_lbl.textColor = COLOR_TINE_BLACK_GREEN;

            [cell.contentView addSubview:address_lbl];

        }
        
        
    } else if(indexPath.section == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        UIImageView *sepLineView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43, PHONE_WIDTH-10, 0.5)];
        sepLineView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        
        [cell addSubview:sepLineView];

        if(indexPath.row == 0) {
        
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = @"Food you like";
            
            food_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            food_lbl.font = [UIFont systemFontOfSize:14];
            food_lbl.text = self.food;
            food_lbl.textAlignment = NSTextAlignmentRight;
            food_lbl.textColor = COLOR_TINE_BLACK_GREEN;

            [cell.contentView addSubview:food_lbl];
            
        } else if(indexPath.row == 1) {
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = @"Hobby";
            
            hobby_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            hobby_lbl.font = [UIFont systemFontOfSize:14];
            hobby_lbl.text = self.hobby;
            hobby_lbl.textAlignment = NSTextAlignmentRight;
            hobby_lbl.textColor = COLOR_TINE_BLACK_GREEN;

            [cell.contentView addSubview:hobby_lbl];
            
        } else if(indexPath.row == 2) {
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = @"Next place to visit";

            visit_lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, PHONE_WIDTH-100-40, 34)];
            visit_lbl.font = [UIFont systemFontOfSize:14];
            visit_lbl.text = self.visitPlace;
            visit_lbl.textAlignment = NSTextAlignmentRight;
            visit_lbl.textColor = COLOR_TINE_BLACK_GREEN;

            [cell.contentView addSubview:visit_lbl];
        }
    }
    
    return cell;
}

- (void)personalInfoEdit:(UILabel*)infoLabel {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTaped)];
    [infoLabel addGestureRecognizer:singleTap];
    [infoLabel setUserInteractionEnabled:YES];
}

- (void)labelTaped{
    
}
#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    status_textField.text = textField.text;
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -
#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self.navigationController presentViewController:picker animated:YES completion:NULL];
        
    } else if(buttonIndex == 1) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self.navigationController presentViewController:picker animated:YES completion:NULL];
        
    }
}

#pragma mark -
#pragma mark UIImagePIckercontroller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    photo_view.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
