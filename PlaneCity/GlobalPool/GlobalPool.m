//
//  GlobalPool.m
//  Breezy
//
//  Created by GlennChiu on 2/25/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import "GlobalPool.h"

@implementation GlobalPool

+ (GlobalPool *)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^
                  {
                      sharedInstance = [self new];
                      
                  });
    
    return sharedInstance;
}

- (id)init {
    
    if(self = [super init]) {
        
        self.fullname = @"";
        self.status = @"I am photographer!";
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"airports" ofType:@"json"];
        NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        NSError *error =  nil;
        NSArray *airArrayFull = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        self.airportArray = [NSMutableArray array];
        for(NSDictionary *item in airArrayFull) {
            if([[item objectForKey:@"iso"] isEqualToString:@"CA"] || [[item objectForKey:@"iso"] isEqualToString:@"US"])
                [self.airportArray addObject:[item objectForKey:@"iata"]];
//                [self.airportArray addObject:[NSString stringWithFormat:@"%@(%@)",[item objectForKey:@"iata"],[item objectForKey:@"name"]]];
        }
        
    }
    
    return self;
    
}

@end
