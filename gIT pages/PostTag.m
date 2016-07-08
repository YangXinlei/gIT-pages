//
//  PostTag.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostTag.h"

@implementation PostTag

-(instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _name = name;
        _posts = [NSArray array];
    }
    return self;
}

@end
