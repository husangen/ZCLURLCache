//
//  ZCLUrlDownloader.h
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCLUrlDownloader : NSObject

+ (ZCLUrlDownloader*)shareUrlDownloader;

- (void)downloadUrl:(NSString*)url completed:(void (^)(NSData*, NSError*)) completed;

@end
