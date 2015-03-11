//
//  ZCLUrlDownloader.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/10.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "ZCLUrlDownloader.h"

@implementation ZCLUrlDownloader

+ (ZCLUrlDownloader*)shareUrlDownloader
{
    static ZCLUrlDownloader* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[ZCLUrlDownloader alloc] init];
    });

    return instance;
}


- (void)downloadUrl:(NSString *)url completed:(void (^)(NSData *, NSError *))completed
{
    NSLog(@"start download %@.", url);
    
    NSURL* surl = [NSURL URLWithString:url];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:surl];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (completed)
        {
            completed(data, connectionError);
            
            NSLog(@"Download %@ completed.", url);
        }
    }];
}

@end

