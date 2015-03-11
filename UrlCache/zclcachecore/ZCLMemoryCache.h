//
//  ZCLMemoryCache.h
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCLMemoryCache : NSObject

+ (ZCLMemoryCache*)shareMemoryCache;

- (BOOL) urlInMemoryCache:(NSString*)url;
- (NSData*) dataWithUrl:(NSString*)url;
- (void)addData:(NSData*)data withUrl:(NSString*)url;
- (void)cleanMemoryCache;

@end
