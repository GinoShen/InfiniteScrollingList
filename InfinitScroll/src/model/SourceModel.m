//
//  SourceModel.m
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import "SourceModel.h"

@implementation SourceModel

- (id) initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        self.sender = [data objectForKey:@"sender"] && [data objectForKey:@"sender"]!=[NSNull null]?[data objectForKey:@"sender"]:@"";
        self.note = [data objectForKey:@"note"] && [data objectForKey:@"note"]!=[NSNull null]?[data objectForKey:@"note"]:@"";
        
    }
    return self;
}

@end
