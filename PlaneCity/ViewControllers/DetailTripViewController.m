//
//  DetailTripViewController.m
//  PlaneCity
//
//  Created by GlennChiu on 6/2/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstant.h"
#import "DetailTripViewController.h"
#import "PlaneInViewController.h"
#import "public.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LIALinkedInApplication.h"

@interface DetailTripViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *terminalScrollView;
@property (nonatomic, strong) UIImageView *terminalView;

@end

@implementation DetailTripViewController
@synthesize terminalScrollView,terminalView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"topcamera_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnClicked)];
    
    self.terminalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, PHONE_WIDTH , 300)];
    
    [self.view addSubview:terminalScrollView];
    
    UIImage *terminalImage = [UIImage imageNamed:@"sfo_terminal.png"];
    
    self.terminalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PHONE_WIDTH , 300)];
    terminalView.image = terminalImage;
    terminalView.contentMode = UIViewContentModeScaleAspectFit;
    
    [terminalScrollView addSubview:terminalView];
    
    terminalScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    terminalScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    terminalScrollView.delegate = self;
    
    terminalScrollView.contentSize = terminalImage.size;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [terminalScrollView addGestureRecognizer:doubleTapRecognizer];
    
    // Add two finger recognizer to the scrollView
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [terminalScrollView addGestureRecognizer:twoFingerTapRecognizer];
    [self setupScales];
    
    
    UIImageView *airplaceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, terminalScrollView.bottom, PHONE_WIDTH, PHONE_HEIGHT-terminalScrollView.bottom)];
    airplaceView.image = [UIImage imageNamed:@"plane_hort.png"];
    airplaceView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:airplaceView];
    
    UILabel *lblAirNumber= [[UILabel alloc] initWithFrame:CGRectMake(20, terminalScrollView.bottom+20, PHONE_WIDTH-40, 30)];
    lblAirNumber.textAlignment = NSTextAlignmentLeft;
    lblAirNumber.textColor = COLOR_TINT_BLACK_MEDIUM;
    lblAirNumber.text = @"AA193";
    
    UILabel *lblAirDate = [[UILabel alloc] initWithFrame:CGRectMake(20, terminalScrollView.bottom+20, PHONE_WIDTH-40, 30)];
    lblAirDate.textAlignment = NSTextAlignmentRight;
    lblAirDate.textColor = COLOR_TINT_BLACK_MEDIUM;
    lblAirDate.text = @"18 May";
    
    [self.view addSubview:lblAirNumber];
    [self.view addSubview:lblAirDate];
    
    UIButton *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView setImage:[UIImage imageNamed:@"detail_view_icon.png"] forState:UIControlStateNormal];
    [btnView addTarget:self action:@selector(btnViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnView.right = PHONE_WIDTH - 40;
    btnView.bottom = PHONE_HEIGHT - 44 - 64;
    btnView.width = 32;
    btnView.height = 23;
    
    [self.view addSubview:btnView];
    // Do any additional setup after loading the view.
}

- (void)btnViewClicked:(id) sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    if (userName != nil && ![userName isEqualToString:@""]) {
        AppDelegate *delegator = DELEGATOR_CALL;
        if (delegator.isLILogged){
            //            LIALinkedInHttpClient *_client = [self client];
            
            [[self client] getAuthorizationCode:^(NSString * code) {
                [[self client] getAccessToken:code success:^(NSDictionary *accessTokenData) {
                    NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
                    [self requestMeWithToken:accessToken];
                } failure:^(NSError *error) {
                }];
            } cancel:^{
            } failure:^(NSError *error) {
                
            }];
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

- (void)photoBtnClicked {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"Back";

    self.navigationItem.title = @"PlaneCity";
}

#pragma mark -
#pragma mark - Scroll View scales setup and center

-(void)setupScales {
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.terminalScrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.terminalScrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.terminalScrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.terminalScrollView.minimumZoomScale = minScale;
    self.terminalScrollView.maximumZoomScale = 3.0f;
    self.terminalScrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    // This method centers the scroll view contents also used on did zoom
    CGSize boundsSize = self.terminalScrollView.bounds.size;
    CGRect contentsFrame = self.terminalView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.terminalView.frame = contentsFrame;
}

#pragma mark -
#pragma mark - ScrollView Delegate methods
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.terminalView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

#pragma mark -
#pragma mark - ScrollView gesture methods
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.terminalView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.terminalScrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.terminalScrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.terminalScrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.terminalScrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.terminalScrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.terminalScrollView.minimumZoomScale);
    [self.terminalScrollView setZoomScale:newZoomScale animated:YES];
}

#pragma mark -
#pragma mark - Rotation

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // When the orientation is changed the contentSize is reset when the frame changes. Setting this back to the relevant image size
    self.terminalScrollView.contentSize = self.terminalView.image.size;
    // Reset the scales depending on the change of values
    [self setupScales];
}

- (void)chatBtnClicked {
    
}
@end
