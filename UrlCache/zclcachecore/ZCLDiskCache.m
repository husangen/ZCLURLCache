//
//  ZCLDiskCache.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "ZCLDiskCache.h"
#import "ZCLUtil.h"

#define CACHEDIR @"me.5long.zh.cache"

@implementation ZCLDiskCache

+ (ZCLDiskCache*)shareDiskCache
{
    static ZCLDiskCache* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[ZCLDiskCache alloc] init];
        [instance createCacheDir];
    });
    
    return instance;
}


- (BOOL)urlInDiskCache:(NSString *)url
{
    NSString* path = [self url2DiskPath:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exists = [fileManager fileExistsAtPath:path];
    
    return exists;
}


- (NSData*)dataWithUrl:(NSString*)url
{
    NSString* path = [self url2DiskPath:url];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    return data;
}


- (void)addData:(NSData *)data withUrl:(NSString *)url
{
    if (!data || !url)
    {
        return;
    }
    
    NSString* path = [self url2DiskPath:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        [fileManager removeItemAtPath:path error:nil];
    }
    if (![fileManager createFileAtPath:path contents:data attributes:nil])
    {
        NSLog(@"save data with %@ error.", url);
    }
    else
    {
        NSLog(@"save data with %@ success.", url);
    }
}


- (void)cleanDiskCache
{
    NSString* cacheDir = [self cacheDir];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    [fileManager removeItemAtPath:cacheDir error:&error];
    if (!error)
    {
        [self createCacheDir];
    }
    else
    {
        NSLog(@"Clear disk cache error");
    }
}


#pragma private

- (NSString*)cacheDir
{
    NSString* dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* cacheDir = [dir stringByAppendingPathComponent:CACHEDIR];
    
    return cacheDir;
}


- (void)createCacheDir
{
    NSString* cacheDir = [self cacheDir];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if (![fileManager fileExistsAtPath:cacheDir isDirectory:&isDir])
    {
        [fileManager createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


- (NSString*)url2DiskPath:(NSString*)url
{
    NSString* fileName = [ZCLUtil md5_32:url];
    NSString* cacheDir = [self cacheDir];
    NSString* path = [cacheDir stringByAppendingPathComponent:fileName];
    
    return path;
}

@end
