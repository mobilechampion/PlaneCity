//
//  PLGPromiseGroup.h
//  Pledge
//
//  Created by Matt Massicotte on 12/14/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#import "PLGPromise.h"

@interface PLGPromiseGroup : PLGPromise {
    NSArray*   _promises;
    NSUInteger _unresolvedPromises;
}

+ (instancetype)groupWithPromises:(NSArray*)promises;

@property (nonatomic, retain) NSArray* promises;

@end
