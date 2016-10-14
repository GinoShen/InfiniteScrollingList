//
//  RecordModel.h
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MAXIMUN_DOWNLOAD_COUNT_PER_TIME     10

@class SourceModel;
@class DestinationModel;

@interface RecordModel : NSObject
@property (nonatomic, strong) NSNumber *recordId;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) SourceModel *source;
@property (nonatomic, strong) DestinationModel *destination;
@property float cellHeight;
- (id) initWithData:(NSDictionary *)data;
+ (void) getRecordFromIndex:(NSNumber *)index completion:(void(^)(id data))completion failure:(void(^)(NSError *error))failure;

@end
