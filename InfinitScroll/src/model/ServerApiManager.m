//
//  ServerApiManager.m
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import "ServerApiManager.h"
#import "RecordModel.h"

@interface ServerApiManager ()

@end


@implementation ServerApiManager

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a blocsk object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
        
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    return self;
}


+ (void) callAPIGetRecordFromIndex:(NSNumber *)index completion:(void (^)(id data))completion failure:(void (^)(NSError *error))failure {
    NSString *urlStr = [NSString stringWithFormat:@"https://hook.io/syshen/infinite-list?startIndex=%@&num=%d", index, MAXIMUN_DOWNLOAD_COUNT_PER_TIME];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            if (data) {
                NSArray* result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
                completion(result);
            }else{
                completion(nil);
            }
        }
    }];
    
    [task resume];
}

@end
