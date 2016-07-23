//
//  PLGContextSavePromise.h
//  Pledge
//
//  Created by Matt Massicotte on 2/5/13.
//  Copyright (c) 2013 Crashlytics. All rights reserved.
//

#import "PLGCoreDataPromise.h"

@interface PLGContextSavePromise : PLGCoreDataPromise

// assumes main queue
+ (instancetype)savePromiseWithManagedObjectContext:(NSManagedObjectContext*)context;

+ (instancetype)savePromiseOnQueue:(dispatch_queue_t)queue withManagedObjectContext:(NSManagedObjectContext*)context;

- (void)addResolutionHandler:(void (^)(NSManagedObjectContext* context))handler;
- (void)addRejectionHandler:(void (^)(NSManagedObjectContext* context, NSError* error))handler;

@end
