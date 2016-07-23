//
//  PLGMultipartMimeStreamEncoder.h
//  Pledge
//
//  Created by Matt Massicotte on 2/7/13.
//  Copyright (c) 2013 Crashlytics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLGMultipartMimeStreamEncoder : NSObject {
    NSMutableArray* _parts;
    NSInputStream*  _inputStream;
    NSOutputStream* _outputStream;
    NSInputStream*  _dataStream;
    
    uint8_t*        _buffer;
    size_t          _cursor;
    ssize_t         _bufferSize;
    unsigned long long _totalStreamLength;
    
    BOOL            _allowHTTPChunking;
}

+ (instancetype)encoder;

- (void)addFileData:(NSData*)data fileName:(NSString*)fileName mimeType:(NSString*)mimeType fieldName:(NSString*)name;
- (void)addFile:(NSURL*)fileURL fileName:(NSString*)fileName mimeType:(NSString*)mimeType fieldName:(NSString*)name;
- (void)addValue:(id)value fieldName:(NSString*)name;

@property (nonatomic, copy,   readonly) NSString*      contentType;
@property (nonatomic, retain, readonly) NSInputStream* inputStream;
@property (nonatomic, copy,   readonly) NSString*      contentLength;

@property (nonatomic, assign)           BOOL           allowHTTPChunking;

@end
