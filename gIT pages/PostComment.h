//
//  PostComment.h
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostItem;
@class Blogger;

@interface PostComment : NSObject

@property (nonatomic, weak) PostItem    *post;      // 评论文章
@property (nonatomic, weak) Blogger     *blogger;   // 评论人
@property (nonatomic, strong) NSString  *content;   // 评论内容
@property (nonatomic, strong) NSDate    *date;      // 评论日期

- (instancetype)initWithPost:(PostItem *)post Blogger:(Blogger *)blogger Content:(NSString *)content Date:(NSString *)dateStr;

@end
