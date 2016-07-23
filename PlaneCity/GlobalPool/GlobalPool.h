//
//  GlobalPool.h
//  Breezy
//
//  Created by GlennChiu on 2/25/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GlobalPool : NSObject

+ (GlobalPool *)sharedInstance;

@property (nonatomic, strong) NSString* fullname;
@property (nonatomic, strong) NSString* photo_url;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSMutableArray*  airportArray;

@property (nonatomic, assign) BOOL isLoggedIn;

@end