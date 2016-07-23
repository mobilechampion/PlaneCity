//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

#import "AppConstant.h"

#import "push.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void ParsePushUserAssign(void)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFInstallation *installation = [PFInstallation currentInstallation];
	installation[PF_INSTALLATION_USER] = [PFUser currentUser];
	[installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil)
		{
			NSLog(@"ParsePushUserAssign save error.");
		}
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void ParsePushUserResign(void)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFInstallation *installation = [PFInstallation currentInstallation];
	[installation removeObjectForKey:PF_INSTALLATION_USER];
	[installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil)
		{
			NSLog(@"ParsePushUserResign save error.");
		}
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void SendPushNotification(NSString *groupId, NSString *text)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFUser *user = [PFUser currentUser];
	NSString *message = [NSString stringWithFormat:@"%@: %@", user[PF_USER_FULLNAME], text];

	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
	[query whereKey:PF_RECENT_USER notEqualTo:user];
	[query includeKey:PF_RECENT_USER];
	[query setLimit:1000];

	PFQuery *queryInstallation = [PFInstallation query];
	[queryInstallation whereKey:PF_INSTALLATION_USER matchesKey:PF_RECENT_USER inQuery:query];

	PFPush *push = [[PFPush alloc] init];
	[push setQuery:queryInstallation];
	[push setMessage:message];
	[push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil)
		{
			NSLog(@"SendPushNotification send error.");
		}
	}];
}
