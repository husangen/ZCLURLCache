//
//  MasterViewController.m
//  UrlCache
//
//  Created by chaolongzhang on 15/3/11.
//  Copyright (c) 2015年 5long. All rights reserved.
//

#import "MasterViewController.h"
#import "ZCLCacheManager.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) ZCLCacheManager* cacheManager;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[@"http://zh.5long.me/assets/images/demo/urlcache/01.jpg",
                   @"http://zh.5long.me/assets/images/demo/urlcache/02.jpg",
                   @"http://zh.5long.me/assets/images/demo/urlcache/03.jpg",
                   @"http://zh.5long.me/assets/images/demo/urlcache/04.jpg",
                   @"http://zh.5long.me/assets/images/demo/urlcache/05.jpg",
                   @"http://zh.5long.me/assets/images/demo/urlcache/06.jpg",
                   @"http://zh.5long.me/assets/images/demo/urlcache/07.jpg",];
    self.cacheManager = [ZCLCacheManager shareCacheManager];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* indentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    NSString* url = [self.items objectAtIndex:indexPath.row];
    
    UILabel* label = (UILabel*)[cell viewWithTag:102];
    label.text = url;
    
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:101];
    imageView.image = [UIImage imageNamed:@"meplace.png"];
    [self.cacheManager asynDataWithUrl:url completed:^(NSData *data)
    {
        UIImage* image = [UIImage imageWithData:data];
        imageView.image = image;
    }];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
    DetailViewController* viewController = [segue destinationViewController];
    viewController.url = [self.items objectAtIndex:indexPath.row];
}

- (IBAction)cleanMemoryCachePressed:(UIBarButtonItem*)sender
{
    [self.cacheManager cleanMemoryCache];
}

- (IBAction)cleanDiskCachePressed:(UIBarButtonItem*)sender
{
    [self.cacheManager cleanDiskCache];
}

@end
