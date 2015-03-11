更详细的介绍请参考本人[博客·iOS网络资源缓存ZCLURLCache]( http://zh.5long.me/2015/ios-zcl-url-cache/)

# iOS网络资源缓存ZCLURLCache

ZCLURLCache是一个轻量级的网络资源缓存组件，具有如下特点：

1.  使用`NSData`保存数据，可以转换成`NSData`的数据都可以存储，如图片、html、声音、视频等文件。
2.  通过一个URL请求数据时，若已有缓存，则直接使用缓存数据。
3.  使用异步方式下载数据，不会阻塞主线程。
4.  使用一致的`block`返回数据，使用缓存还是下载数据是透明的。
5.  使用MD5编码URL，确保文件不会重复。

#ZCLURLCache的流程
当通过某个URL获取数据时，组件的流程如下：

1.  检查URL对应的数据是否在内存中有缓存，若有，直接取出数据返回，否则进入第二步。
2.  检查URL对应的数据是否在磁盘上又缓存，若有，从磁盘上读取数据，把数据放入内存缓存，并返回数据。
3.  联网下载URL对应的数据，下载完后分别缓存在内存和磁盘，返回数据。

#ZCLURLCache架构
ZCLURLCache分为五个类：

1.  ZCLCacheManager，缓存管理类，单例，也是时唯一一个需要在客户端代码中使用的类。
2.  ZCLMemoryCache，内存缓存类，在内存中缓存数据并提供相关方法。
3.  ZCLDiskCache，磁盘缓存类，在磁盘上缓存数据并提供相关方法。
4.  ZCLUrlDownloader，数据下载类。
5.  ZCLUtil，工具类，MD5编码。

#ZCLURLCache的使用
##获取URL数据
ZCLURLCache的使用非常简单，步骤如下：

1.  拷贝上述五个类文件到项目工程下（在文件`zclcachecore`）。
2.  在要使用的类中引用头文件`#import "ZCLCacheManager.h"`。
3.  调用`[ZCLCacheManager shareCacheManager]`获得缓存管理类的单例。
4.  调用`- (void)asynDataWithUrl:(NSString*)url completed:(void (^)(NSData*))completed`获得数据，数据从`block`返回，如在`UITableView`中可以这样使用：

```objective-c
UIImageView* imageView = (UIImageView*)[cell viewWithTag:101];
imageView.image = [UIImage imageNamed:@"meplace.png"];
[self.cacheManager asynDataWithUrl:url completed:^(NSData *data)
{
    UIImage* image = [UIImage imageWithData:data];
    imageView.image = image;
}];
```

##清空缓存
缓存管理类（ZCLCacheManager）提供两个方法分别清空内存缓存和磁盘缓存：

1.  `cleanMemoryCache`，清空内存缓存。
2.  `cleanDiskCache`，清空磁盘缓存。

调用前需要调用`[ZCLCacheManager shareCacheManager]`获得缓存管理类的单例，如：

```objective-c
ZCLCacheManager* cacheManager = [ZCLCacheManager shareCacheManager];
[cacheManager cleanMemoryCache];
[cacheManager cleanDiskCache];
```

#申明
本组件完全开源，任何人可以用于任何目的，包括商业用途，但本人不承担任何因该组件带来的后果。
