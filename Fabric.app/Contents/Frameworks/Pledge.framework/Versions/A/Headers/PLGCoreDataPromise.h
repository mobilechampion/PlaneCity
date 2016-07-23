//
//  PLGCoreDataPromise.h
//  Pledge
//
//  Created by Matt Massicotte on 2/5/13.
//  Copyright (c) 2013 Crashlytics. All rights reserved.
//

#import "PLGPromise.h"

@interface PLGCoreDataPromise : PLGPromise {
    NSManagedObjectContext* _context;
    dispatch_queue_t        _contextQueue;
}

@property (nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic, assign) dispatch_queue_t        contextQueue;

@end
