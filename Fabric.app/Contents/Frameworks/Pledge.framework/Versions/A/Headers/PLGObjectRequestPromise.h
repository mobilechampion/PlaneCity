//
//  PLGObjectRequestPromise.h
//  Pledge
//
//  Created by Matt Massicotte on 12/14/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import "PLGHTTPRequestPromise.h"
#import "PLGObjectPromise.h"

typedef void(^PLGObjectPromiseResolutionHandler)(NSURLRequest* request, NSHTTPURLResponse *response, id <NSObject> object);

typedef id <NSObject>(^PLGObjectRequestTransformerBlock)(id <NSObject>);

@interface PLGObjectRequestPromise : PLGHTTPRequestPromise {
    id <NSObject> _object;
    PLGObjectRequestTransformerBlock _objectTransformer;
}

@property (nonatomic, copy) PLGObjectRequestTransformerBlock objectTransformer;

- (void)addResolutionHandler:(PLGObjectPromiseResolutionHandler)handler;

@end
