//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

#import "AppConstant.h"

#import "group.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void RemoveGroupMembers(PFUser *user1, PFUser *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
	[query whereKey:PF_GROUP_USER equalTo:user1];
	[query whereKey:PF_GROUP_MEMBERS equalTo:user2.objectId];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			for (PFObject *group in objects)
			{
				RemoveGroupMember(group, user2);
			}
		}
		else NSLog(@"RemoveGroupMembers query error.");
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void RemoveGroupMember(PFObject *group, PFUser *user)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if ([group[PF_GROUP_MEMBERS] containsObject:user.objectId])
	{
		[group[PF_GROUP_MEMBERS] removeObject:user.objectId];
		[group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
		{
			if (error != nil) NSLog(@"RemoveGroupMember save error.");
		}];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void RemoveGroupItem(PFObject *group)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[group deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) NSLog(@"RemoveGroupItem delete error.");
	}];
}
