//
//  ZCLCacheManager.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "ZCLCacheManager.h"

#import "ZCLUrlDownloader.h"
#import "ZCLDiskCache.h"
#import "ZCLMemoryCache.h"

@interface ZCLCacheManager ()

@property (nonatomic, strong) ZCLMemoryCache* memoryCache;
@property (nonatomic, strong) ZCLDiskCache* diskCache;
@property (nonatomic, strong) ZCLUrlDownloader* urlDownload;

@end

@implementation ZCLCacheManager

+ (ZCLCacheManager*)shareCacheManager
{
    static ZCLCacheManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[ZCLCacheManager alloc] init];
    });

    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.memoryCache = [ZCLMemoryCache shareMemoryCache];
        self.diskCache = [ZCLDiskCache shareDiskCache];
        self.urlDownload = [ZCLUrlDownloader shareUrlDownloader];
    }
    return self;
}


- (void)asynDataWithUrl:(NSString*)url completed:(void (^)(NSData*))completed
{
    NSData* data = nil;
    
    if ([self.memoryCache urlInMemoryCache:url])
    {
        data = [self.memoryCache dataWithUrl:url];
        completed(data);
        
        //NSLog(@"get data from memory.");
    }
    else if ([self.diskCache urlInDiskCache:url])
    {
        data = [self.diskCache dataWithUrl:url];
        [self.memoryCache addData:data withUrl:url];
        completed(data);
        
        //NSLog(@"get data from disk.");
    }
    else
    {
        [self.urlDownload downloadUrl:url completed:^(NSData* data, NSError* error)
        {
            if (error)
            {
                data = nil;
            }
            else
            {
                completed(data);
                [self.memoryCache addData:data withUrl:url];
                [self.diskCache addData:data withUrl:url];
            }
        }];
    }
}


- (void)cleanMemoryCache
{
    [self.memoryCache cleanMemoryCache];
}


- (void)cleanDiskCache
{
    [self.diskCache cleanDiskCache];
}

@end
