//
//  PostItem.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostItem.h"

// 文章
@implementation PostItem

-(instancetype)initWithTitle:(NSString *)title Url:(NSString *)urlStr Blogger:(Blogger *)blogger Twitter:(Blogger *)twitter Tag:(PostTag *)tag Comments:(NSArray<PostComment *> *)comments Likes:(NSUInteger)likes Date:(NSString *)dateStr
{
    self = [super init];
    if (self)
    {
        _title = title;
        _url = [NSURL URLWithString:urlStr];
        _blogger = blogger;
        _twitter = twitter;
        _tag = tag;
        _comments = comments;
        _likes = likes;
        NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
        [tmpFormatter setDateFormat:@"YYYY'-'MM'-'dd'T'HH':'mm':'ss'+00:00'"];
        _date = [tmpFormatter dateFromString:dateStr];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title: %@, url: %@", _title, _url];
}

@end
