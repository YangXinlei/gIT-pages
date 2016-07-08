//
//  PostItem.h
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Blogger;
@class PostTag;
@class PostComment;

@interface PostItem : NSObject

@property (nonatomic, strong) NSString                      *title;             // 文章标题
@property (nonatomic, strong) NSURL                         *url;               // 原文链接
@property (nonatomic, weak) Blogger                         *blogger;           // 作者
@property (nonatomic, weak) Blogger                         *twitter;           // 推荐者
@property (nonatomic, weak) PostTag                         *tag;               // 文章标签
@property (nonatomic, assign) NSUInteger                    likes;              // 点赞数
@property (nonatomic, strong) NSArray<PostComment *>        *comments;          // 评论
@property (nonatomic, strong) NSDate                        *date;              // 创建时间

- (instancetype)initWithTitle:(NSString *)title Url:(NSString *)urlStr Blogger:(Blogger *)blogger Twitter:(Blogger *)twitter Tag:(PostTag *)tag Comments:(NSArray<PostComment *> *)comments Likes:(NSUInteger)likes Date:(NSString *)dateStr;

@end
