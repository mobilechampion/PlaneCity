//
//  PLGObjectPromise.h
//  Pledge
//
//  Created by Matt Massicotte on 12/14/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import "PLGPromise.h"

@interface PLGObjectPromise : PLGPromise {
    id _object;
}

@property (nonatomic, retain) id object;

- (void)resolveWithObject:(id)object;

- (void)addResolutionHandler:(void (^)(id object))handler;

@end
