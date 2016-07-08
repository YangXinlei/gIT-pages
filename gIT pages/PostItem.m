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

- (NSString *)description
{
    return [NSString stringWithFormat:@"title: %@, url: %@", _title, _url];
}

@end
