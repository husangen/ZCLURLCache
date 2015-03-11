//
//  ZCLUtil.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "ZCLUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ZCLUtil

+ (NSString*)md5_32:(NSString *)string
{
    const char* originalStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(originalStr, (CC_LONG)strlen(originalStr), result);
    NSMutableString* hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

@end
