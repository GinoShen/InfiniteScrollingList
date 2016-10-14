//
//  ServerApiManager.h
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/13.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerApiManager : NSObject
+ (void) callAPIGetRecordFromIndex:(NSNumber *)index completion:(void (^)(id data))completion failure:(void (^)(NSError *error))failure;
@end
