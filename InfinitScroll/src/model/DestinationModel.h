//
//  DestinationModel.h
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationModel : NSObject
@property (nonatomic, strong) NSString *recipient;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *currency;
- (id) initWithData:(NSDictionary *)data;

@end
