//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString*		StartPrivateChat		(PFUser *user1, PFUser *user2);
NSString*		StartMultipleChat		(NSMutableArray *users);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			CreateRecentItem		(PFUser *user, NSString *groupId, NSArray *members, NSString *description);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			UpdateRecentCounter		(NSString *groupId, NSInteger amount, NSString *lastMessage);
void			ClearRecentCounter		(NSString *groupId);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			DeleteRecentItems		(PFUser *user1, PFUser *user2);
