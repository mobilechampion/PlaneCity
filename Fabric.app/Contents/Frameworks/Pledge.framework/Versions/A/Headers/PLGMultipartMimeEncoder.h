//
//  PLGMultipartMimeEncoder.h
//  MacApp
//
//  Created by Matt Massicotte on 1/28/13.
//  Copyright (c) 2013 Crashlytics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLGMultipartMimeEncoder : NSObject {
    NSMutableArray* _parts;
}

+ (void)encodeForURLRequest:(NSMutableURLRequest*)request usingEncoder:(void (^)(PLGMultipartMimeEncoder* encoder))encoderBlock;
+ (instancetype)encoder;

- (void)addFileData:(NSData*)data fileName:(NSString*)fileName mimeType:(NSString*)mimeType fieldName:(NSString*)name;
- (void)addValue:(id)value fieldName:(NSString*)name;

- (BOOL)encodeToData:(NSData**)data contentType:(NSString**)contentType error:(NSError**)error;

@end
