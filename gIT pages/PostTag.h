//
//  PostTag.h
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostItem;

// 文章标签
@interface PostTag : NSObject

@property (nonatomic, strong) NSString              *name;          // 标签名
@property (nonatomic, strong) NSArray<PostItem*>    *posts;         // 从属该标签的文章列表

- (instancetype)initWithName:(NSString *)name;

@end
