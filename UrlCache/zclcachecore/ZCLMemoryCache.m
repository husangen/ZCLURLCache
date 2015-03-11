//
//  ZCLMemoryCache.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "ZCLMemoryCache.h"
#import "ZCLUtil.h"

@interface ZCLMemoryCache ()

@property (nonatomic, strong) NSCache* memoryCache;

@end

@implementation ZCLMemoryCache

+ (ZCLMemoryCache*)shareMemoryCache
{
    static ZCLMemoryCache* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      instance = [[ZCLMemoryCache alloc] init];
                  });
    
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.memoryCache = [[NSCache alloc] init];
    }
    
    return self;
}


- (BOOL)urlInMemoryCache:(NSString*)url
{
    id data = [self dataWithUrl:url];
    
    return nil != data;
}


- (NSData*) dataWithUrl:(NSString*)url
{
    NSString* key = [ZCLUtil md5_32:url];
    NSData* data = (NSData*)[self.memoryCache objectForKey:key];
    
    return data;
}


- (void)addData:(NSData*)data withUrl:(NSString*)url
{
    NSString* key = [ZCLUtil md5_32:url];
    [self.memoryCache setObject:data forKey:key];
}


- (void)cleanMemoryCache
{
    [self.memoryCache removeAllObjects];
}

@end
