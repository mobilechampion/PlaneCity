//
//  PLGFetchRequestPromise.h
//  MacApp
//
//  Created by Matt Massicotte on 12/17/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import "PLGCoreDataPromise.h"

@interface PLGFetchRequestPromise : PLGCoreDataPromise {
    NSFetchRequest* _request;
    NSArray*        _results;
}

+ (instancetype)promiseWithFetchRequest:(NSFetchRequest*)request onQueue:(dispatch_queue_t)queue inManagedObjectContext:(NSManagedObjectContext*)context;
+ (instancetype)promiseWithFetchRequest:(NSFetchRequest*)request inManagedObjectContext:(NSManagedObjectContext*)context;

- (void)addResolutionHandler:(void (^)(NSFetchRequest* request, NSManagedObjectContext* context, NSArray* results))handler;
- (void)addRejectionHandler:(void (^)(NSFetchRequest* request, NSManagedObjectContext* context, NSError* error))handler;

@end
