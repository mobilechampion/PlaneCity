//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import "image.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
UIImage* SquareImage(UIImage *image, CGFloat size)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UIImage *cropped;
	if (image.size.height > image.size.width)
	{
		CGFloat ypos = (image.size.height - image.size.width) / 2;
		cropped = CropImage(image, 0, ypos, image.size.width, image.size.width);
	}
	else
	{
		CGFloat xpos = (image.size.width - image.size.height) / 2;
		cropped = CropImage(image, xpos, 0, image.size.height, image.size.height);
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UIImage *resized = ResizeImage(cropped, size, size);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return resized;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
UIImage* ResizeImage(UIImage *image, CGFloat width, CGFloat height)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGSize size = CGSizeMake(width, height);
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
	[image drawInRect:rect];
	UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resized;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
UIImage* CropImage(UIImage *image, CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGRect rect = CGRectMake(x, y, width, height);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
	UIImage *cropped = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return cropped;
}
