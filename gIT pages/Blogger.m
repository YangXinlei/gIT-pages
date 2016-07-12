//
//  Blogger.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "Blogger.h"

@implementation Blogger

-(instancetype)initWithName:(NSString *)name url:(NSString *)urlStr
{
    self = [super init];
    if (self)
    {
        _name = name;
        _url = [NSURL URLWithString:urlStr];
        
        _posts = [NSArray array];
        _sharedPosts = [NSArray array];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ _posts:%@", _name, _posts];
}

@end
