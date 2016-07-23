//
//  PLGURLRequestPromise.h
//  Pledge
//
//  Created by Matt Massicotte on 12/13/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import "PLGPromise.h"

typedef void(^PLGURLRequestPromiseResolutionHandler)(NSURLRequest* request, NSURLResponse *response, NSData* bodyData);
typedef void(^PLGURLRequestPromiseRejectionHandler)(NSURLRequest* request, NSURLResponse *response, NSError* error);

@class PLGMultipartMimeStreamEncoder;
@class PLGMultipartMimeEncoder;

@interface PLGURLRequestPromise : PLGPromise <NSURLConnectionDelegate> {
    NSURLConnection* _connection;
    NSURLRequest*    _request;
    NSURLResponse*   _response;
    NSMutableData*   _data;
}

+ (instancetype)URLRequestPromiseWithURLRequest:(NSURLRequest*)request mimeEncoder:(void (^)(PLGMultipartMimeEncoder* encoder))encoderBlock;
+ (instancetype)URLRequestPromiseWithURLRequest:(NSURLRequest*)request;

@property (nonatomic, retain)           NSURLConnection* connection;
@property (nonatomic, retain, readonly) NSURLResponse*   response;

- (void)addResolutionHandler:(PLGURLRequestPromiseResolutionHandler)handler;
- (void)addRejectionHandler:(PLGURLRequestPromiseRejectionHandler)handler;

@end
