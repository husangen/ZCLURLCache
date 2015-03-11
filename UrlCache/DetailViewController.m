//
//  DetailViewController.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/11.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "DetailViewController.h"
#import "ZCLCacheManager.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController


- (void)viewWillAppear:(BOOL)animated
{
    ZCLCacheManager* cacheManager = [ZCLCacheManager shareCacheManager];
    [cacheManager asynDataWithUrl:self.url completed:^(NSData *data)
     {
         UIImage* image = [UIImage imageWithData:data];
         self.imageView.image = image;
     }];
}

@end
