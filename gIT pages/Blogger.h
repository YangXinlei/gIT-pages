//
//  Blogger.h
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostItem;

// 博主
@interface Blogger : NSObject

@property (nonatomic, strong) NSString              *name;          // name
@property (nonatomic, strong) NSURL                 *url;           // 博客首页
@property (nonatomic, strong) NSArray<PostItem *>   *posts;         // 原创博文
@property (nonatomic, strong) NSArray<PostItem *>   *sharedPosts;   // 分享的博文

- (instancetype)initWithName:(NSString *)name url:(NSString *)urlStr;

@end
