//
//  PostComment.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostComment.h"

@implementation PostComment

-(instancetype)initWithPost:(PostItem *)post Blogger:(Blogger *)blogger Content:(NSString *)content Date:(NSString *)dateStr
{
    self = [super init];
    if (self)
    {
        _post = post;
        _blogger = blogger;
        _content = content;
        NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
        [tmpFormatter setDateFormat:@"YYYY'-'MM'-'dd'T'HH':'mm':'ss'+00:00'"];
        _date = [tmpFormatter dateFromString:dateStr];
    }
    return self;
}

@end
