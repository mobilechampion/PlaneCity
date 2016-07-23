//
//  PLGURLDownloadPromise.h
//  MacApp
//
//  Created by Matt Massicotte on 12/31/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import <Pledge/Pledge.h>

typedef void(^PLGURLDownloadPromiseResolutionHandler)(NSURLRequest* request, NSURLResponse* response, NSString* path, NSString* fileName);
typedef void(^PLGURLDownloadPromiseRejectionHandler)(NSURLRequest* request, NSURLResponse* response, NSError* error);

@interface PLGURLDownloadPromise : PLGPromise {
    NSURLRequest*  _request;
    NSURLDownload* _download;
    NSString*      _path;
    NSString*      _fileName;
}

+ (instancetype)URLDownloadPromiseWithURLRequest:(NSURLRequest*)request toPath:(NSString*)path;

- (void)addResolutionHandler:(PLGURLDownloadPromiseResolutionHandler)handler;
- (void)addRejectionHandler:(PLGURLDownloadPromiseRejectionHandler)handler;

@property (nonatomic, copy, readonly) NSString* path;

@end
