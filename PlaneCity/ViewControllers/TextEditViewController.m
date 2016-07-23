//
//  TextEditViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/15/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "TextEditViewController.h"
#import "public.h"
#import "SettingsViewController.h"

@interface TextEditViewController (){
    UITextView *textView;
}

@end

@implementation TextEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnClicked:)];
    
    self.view.backgroundColor = COLOR_TINT_GRAY;
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, PHONE_WIDTH, 120)];
    textView.text = self.text;
    textView.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:textView];
    
    UITapGestureRecognizer *tap_ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_ges_clicked:)];
    [self.view addGestureRecognizer:tap_ges];
    
    [textView becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap_ges_clicked:(UITapGestureRecognizer*) sender {
    [self.view endEditing:YES];
}

- (void)doneBtnClicked:(id) sender {
        
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:textView.text ,@"text", [NSNumber numberWithInteger:self.interVal], @"val", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"infoEdition" object:dict];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
