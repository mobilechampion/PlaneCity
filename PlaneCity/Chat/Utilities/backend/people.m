//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

#import "AppConstant.h"

#import "people.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void PeopleSave(PFUser *user1, PFUser *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:user1];
	[query whereKey:PF_PEOPLE_USER2 equalTo:user2];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			if ([objects count] == 0)
			{
				PFObject *object = [PFObject objectWithClassName:PF_PEOPLE_CLASS_NAME];
				object[PF_PEOPLE_USER1] = user1;
				object[PF_PEOPLE_USER2] = user2;
				[object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (error != nil) NSLog(@"PeopleSave save error.");
				}];
			}
		}
		else NSLog(@"PeopleSave query error.");
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void PeopleDelete(PFUser *user1, PFUser *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:user1];
	[query whereKey:PF_PEOPLE_USER2 equalTo:user2];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			for (PFObject *people in objects)
			{
				[people deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (error != nil) NSLog(@"PeopleDelete delete error.");
				}];
			}
		}
		else NSLog(@"PeopleDelete query error.");
	}];
}
