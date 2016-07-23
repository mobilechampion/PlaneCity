//
//  PLGPromise.h
//  Pledge
//
//  Created by Matt Massicotte on 12/13/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PLGWeakRef(x) __block __typeof(x)

typedef enum {
    PLGPromiseUnfulfilled = 0,
    PLGPromiseResolved    = 1,
    PLGPromiseRejected    = 2
} PLGPromiseState;

typedef void(^PLGPromiseResolutionHandler)(void);
typedef void(^PLGPromiseRejectionHandler)(NSError* error);

@interface PLGPromise : NSObject {
    PLGPromiseState  _state;
    NSMutableArray*  _resolveHandlers;
    NSMutableArray*  _rejectHandlers;
    dispatch_queue_t _queue;
    NSError*         _error;
    PLGPromise*      _selfRef;
    dispatch_queue_t _callbackQueue;
}

+ (instancetype)promise;

@property (nonatomic, retain) NSError* error;

// useful for subclasses that need to be kicked off
- (void)start;

- (void)resolve;
- (void)reject;
- (void)rejectWithError:(NSError*)error;

- (void)addResolutionHandler:(PLGPromiseResolutionHandler)handler;
- (void)addRejectionHandler:(PLGPromiseRejectionHandler)handler;

@property (nonatomic, assign, readonly) dispatch_queue_t queue;
@property (nonatomic, assign)           dispatch_queue_t callbackQueue;

@end
