//
//  ReviewPostViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "ReviewPostViewController.h"
#import "public.h"
#import "JSImagePickerViewController.h"

@interface ReviewPostViewController ()<JSImagePickerViewControllerDelegate, UIAlertViewDelegate>
{
    UISlider *happySlider;
    
    UIImageView *photoView;
    UILabel *lblCenterValue;
}
@end

@implementation ReviewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    happySlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 20, PHONE_WIDTH-40, 40)];
    happySlider.maximumValue = 1.0;
    happySlider.value = 0.5;
    [happySlider setThumbImage:[UIImage imageNamed:@"em3.png"] forState:UIControlStateNormal];
//    happySlider.thumbTintColor = COLOR_TINT;
    happySlider.tintColor = COLOR_TINT;
    happySlider.maximumTrackTintColor = [UIColor lightGrayColor];
    happySlider.minimumTrackTintColor = COLOR_TINT;
    [happySlider addTarget:self action:@selector(happySliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:happySlider];
    
//    UIImageView *emoji1 = [[UIImageView alloc] initWithFrame:CGRectZero];
//    emoji1.image = [UIImage imageNamed:@"emoji4.png"];
//    emoji1.frame = CGRectMake(20, happySlider.bottom, 32, 32);
//    [self.view addSubview:emoji1];
//    
//    UIImageView *emoji2 = [[UIImageView alloc] initWithFrame:CGRectZero];
//    emoji2.image = [UIImage imageNamed:@"emoji3.png"];
//    emoji2.frame = CGRectMake(20+(PHONE_WIDTH-40)/3-16, happySlider.bottom, 32, 32);
//    [self.view addSubview:emoji2];
//    
//    UIImageView *emoji3 = [[UIImageView alloc] initWithFrame:CGRectZero];
//    emoji3.image = [UIImage imageNamed:@"emoji2.png"];
//    emoji3.frame = CGRectMake(20+(PHONE_WIDTH-40)/3.0*2.0-16, happySlider.bottom, 32, 32);
//    [self.view addSubview:emoji3];
//    
//    UIImageView *emoji4 = [[UIImageView alloc] initWithFrame:CGRectZero];
//    emoji4.image = [UIImage imageNamed:@"emoji1.png"];
//    emoji4.frame = CGRectMake(20+PHONE_WIDTH-40-32, happySlider.bottom, 32, 32);
//    [self.view addSubview:emoji4];
    
    lblCenterValue = [[UILabel alloc] initWithFrame:CGRectMake(20, happySlider.bottom, happySlider.width, 30)];
    lblCenterValue.textAlignment = NSTextAlignmentCenter;
    lblCenterValue.textColor = COLOR_TINT;
    lblCenterValue.text = @"50%";
    lblCenterValue.font = [UIFont boldSystemFontOfSize:20];
    
    [self.view addSubview:lblCenterValue];

    photoView = [[UIImageView alloc]initWithFrame:CGRectMake(15, lblCenterValue.bottom+5, PHONE_WIDTH-30, PHONE_HEIGHT-lblCenterValue.bottom-64-120)];
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.clipsToBounds = YES;
    photoView.layer.cornerRadius = 4;
    photoView.layer.masksToBounds = YES;
    photoView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    photoView.layer.borderWidth = 1.0;
    
    [self.view addSubview:photoView];
    
    UITextView *noteTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, lblCenterValue.bottom+5, PHONE_WIDTH-30, PHONE_HEIGHT-lblCenterValue.bottom-64-120)];
    noteTextView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    noteTextView.layer.cornerRadius = 4;
    noteTextView.layer.masksToBounds = YES;
    noteTextView.font = [UIFont systemFontOfSize:16];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    toolBar.translucent = YES;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWriting)];
    [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace, doneButton, nil]];
    
    noteTextView.inputAccessoryView = toolBar;
    
    [self.view addSubview:noteTextView];
    
    UIButton *btnPicture = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [btnPicture setImage:[UIImage imageNamed:@"picture_attach.png"] forState:UIControlStateNormal];
    [btnPicture addTarget:self action:@selector(btnPictureClicked) forControlEvents:UIControlEventTouchUpInside];
    
    btnPicture.right = noteTextView.width -2;
    btnPicture.bottom = noteTextView.height- 2;
    
    [noteTextView addSubview:btnPicture];
    
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, noteTextView.bottom+30, PHONE_WIDTH/2.5, 40)];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.backgroundColor = COLOR_TINT;
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    doneBtn.left = PHONE_WIDTH/2+20;
    
    [self.view addSubview:doneBtn];

    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, noteTextView.bottom+30, PHONE_WIDTH/2.5, 40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = COLOR_TINT;
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    cancelBtn.right = PHONE_WIDTH/2-20;
    
    [self.view addSubview:cancelBtn];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)happySliderValueChanged:(ASValueTrackingSlider*) slider {
    float val = slider.value;
    lblCenterValue.text = [NSString stringWithFormat:@"%d%%",(int)(val*100.0)];
    if(slider.value<0.2) {
        [happySlider setThumbImage:[UIImage imageNamed:@"em5.png"] forState:UIControlStateNormal];
        
    } else if(slider.value<0.4) {
        
        [happySlider setThumbImage:[UIImage imageNamed:@"em4.png"] forState:UIControlStateNormal];

    } else if(slider.value<0.6) {
        [happySlider setThumbImage:[UIImage imageNamed:@"em3.png"] forState:UIControlStateNormal];

    } else if(slider.value<0.8) {
        [happySlider setThumbImage:[UIImage imageNamed:@"em2.png"] forState:UIControlStateNormal];

    } else {
        [happySlider setThumbImage:[UIImage imageNamed:@"em1.png"] forState:UIControlStateNormal];

    }
    
}

- (void) doneWriting {
    [self.view endEditing:YES];
}

- (void)doneBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelBtnClicked {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PlaneCity Notice" message:@"Are you sure to cancel this review?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show];
}

- (void)btnPictureClicked {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
}
#pragma mark - JSImagePikcerViewControllerDelegate

- (void)imagePickerDidSelectImage:(UIImage *)image {
    photoView.image = image;
    photoView.alpha = 1.0;
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
