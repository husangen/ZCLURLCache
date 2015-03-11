//
//  ZCLCacheManager.h
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCLCacheManager : NSObject

+ (ZCLCacheManager*)shareCacheManager;

- (void)asynDataWithUrl:(NSString*)url completed:(void (^)(NSData* data))completed;
- (void)cleanMemoryCache;
- (void)cleanDiskCache;

@end
