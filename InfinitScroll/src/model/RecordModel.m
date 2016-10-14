//
//  RecordModel.m
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import "RecordModel.h"
#import "SourceModel.h"
#import "DestinationModel.h"
#import "ServerApiManager.h"

@implementation RecordModel

- (id) initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
        
        self.recordId = [data objectForKey:@"id"] && [data objectForKey:@"id"]!=[NSNull null]?[data objectForKey:@"id"]:@-1;
        self.created = [data objectForKey:@"created"] && [data objectForKey:@"created"]!=[NSNull null]?[df dateFromString:[data objectForKey:@"created"]]:[NSDate new];
        self.source = [[SourceModel alloc] initWithData:[data objectForKey:@"source"]];
        self.destination = [[DestinationModel alloc] initWithData:[data objectForKey:@"destination"]];
        CGRect size = [self.source.note boundingRectWithSize:(CGSize){ .width = [[UIScreen mainScreen] bounds].size.width-62, .height = CGFLOAT_MAX }
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14.0] }
                                                     context:nil];
        self.cellHeight = size.size.height+68+ 12+4;
        

    }
    return self;
}

+ (void) getRecordFromIndex:(NSNumber *)index completion:(void(^)(id data))completion failure:(void(^)(NSError *error))failure
{
    [ServerApiManager callAPIGetRecordFromIndex:index completion:^(id data){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *recordList = [[NSMutableArray alloc] init];
            for (NSDictionary *tmp in data) {
                [recordList addObject:[[RecordModel alloc] initWithData:tmp]];
            }
            
            NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self.recordId" ascending:YES];
            [recordList sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion (recordList);
            });
        });
    } failure:^(NSError *error){
        failure(error);
    }];
}

@end
