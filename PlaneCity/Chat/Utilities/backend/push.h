//
// Copyright (c) 2015 Related Code - http://relatedcode.com
//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Parse/Parse.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			ParsePushUserAssign		(void);
void			ParsePushUserResign		(void);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			SendPushNotification	(NSString *groupId, NSString *text);
