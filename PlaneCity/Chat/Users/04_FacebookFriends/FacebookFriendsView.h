//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
@protocol FacebookFriendsDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectFacebookUser:(PFUser *)user;

@end

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface FacebookFriendsView : UITableViewController <UISearchBarDelegate>
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (nonatomic, assign) IBOutlet id<FacebookFriendsDelegate>delegate;

@end
