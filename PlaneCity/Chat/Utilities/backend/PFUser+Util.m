//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import "AppConstant.h"

#import "PFUser+Util.h"

@implementation PFUser (Util)

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSString *)fullname
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return self[PF_USER_FULLNAME];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)isEqualTo:(PFUser *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [self.objectId isEqualToString:user.objectId];
}

@end