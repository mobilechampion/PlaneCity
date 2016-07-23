// UIProgressView+AFNetworking.h
// Copyright (c) 2011–2015 Alamofire Software Foundation (http://alamofire.org/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Foundation/Foundation.h>

#import <Availability.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>

@class AFURLConnectionOperation;

/**
 This category adds methods to the UIKit framework's `UIProgressView` class. The methods in this category provide support for binding the progress to the upload and download progress of a session task or request operation.
 */
@interface UIProgressView (AFNetworking)

///------------------------------------
/// @name Setting Session Task Progress
///------------------------------------

/**
 Binds the progress to the upload progress of the specified session task.

 @param task The session task.
 @param animated `YES` if the change should be animated, `NO` if the change should happen immediately.
 */
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
- (void)setProgressWithUploadProgressOfTask:(NSURLSessionUploadTask *)task
                                   animated:(BOOL)animated;
#endif

/**
 Binds the progress to the download progress of the specified session task.

 @param task The session task.
 @param animated `YES` if the change should be animated, `NO` if the change should happen immediately.
 */
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
- (void)setProgressWithDownloadProgressOfTask:(NSURLSessionDownloadTask *)task
                                     animated:(BOOL)animated;
#endif

///------------------------------------
/// @name Setting Session Task Progress
///------------------------------------

/**
 Binds the progress to the upload progress of the specified request operation.

 @param operation The request operation.
 @param animated `YES` if the change should be animated, `NO` if the change should happen immediately.
 */
- (void)setProgressWithUploadProgressOfOperation:(AFURLConnectionOperation *)operation
                                        animated:(BOOL)animated;

/**
 Binds the progress to the download progress of the specified request operation.

 @param operation The request operation.
 @param animated `YES` if the change should be animated, `NO` if the change should happen immediately.
 */
- (void)setProgressWithDownloadProgressOfOperation:(AFURLConnectionOperation *)operation
                                          animated:(BOOL)animated;

@end

#endif
