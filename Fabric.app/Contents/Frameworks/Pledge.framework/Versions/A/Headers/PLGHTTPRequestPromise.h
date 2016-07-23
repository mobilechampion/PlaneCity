//
//  PLGHTTPRequestPromise.h
//  Pledge
//
//  Created by Matt Massicotte on 12/14/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import "PLGURLRequestPromise.h"

typedef void(^PLGHTTPPromiseRejectionHandler)(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error);
typedef void(^PLGHTTPPromiseResolutionHandler)(NSURLRequest* request, NSHTTPURLResponse* response, NSData* bodyData);

@interface PLGHTTPRequestPromise : PLGURLRequestPromise

- (void)addRejectionHandler:(PLGHTTPPromiseRejectionHandler)handler;
- (void)addResolutionHandler:(PLGHTTPPromiseResolutionHandler)handler;

- (PLGPromise*)plainPromise;

@end
