//
//  SourceModel.h
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceModel : NSObject
@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *note;
- (id) initWithData:(NSDictionary *)data;

@end
