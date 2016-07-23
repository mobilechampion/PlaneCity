//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import "fileutil.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* Applications(NSString *file)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *path = [[NSBundle mainBundle] resourcePath];
	if (file != nil) path = [path stringByAppendingPathComponent:file];
	return path;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* Documents(NSString *file)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	if (file != nil) path = [path stringByAppendingPathComponent:file];
	return path;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* Caches(NSString *file)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	if (file != nil) path = [path stringByAppendingPathComponent:file];
	return path;
}
