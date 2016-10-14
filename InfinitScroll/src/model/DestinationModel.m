//
//  DestinationModel.m
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationModel
- (id) initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        self.recipient = [data objectForKey:@"recipient"] && [data objectForKey:@"recipient"]!=[NSNull null]?[data objectForKey:@"recipient"]:@"";
        self.currency = [data objectForKey:@"currency"] && [data objectForKey:@"currency"]!=[NSNull null]?[data objectForKey:@"currency"]:@"";
        self.amount = [data objectForKey:@"amount"] && [data objectForKey:@"amount"]!=[NSNull null]?[data objectForKey:@"amount"]:@-1;
    }
    return self;
}


@end
