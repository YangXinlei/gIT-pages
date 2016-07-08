//
//  HomePostsManager.h
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostItem.h"

@interface HomePostsManager : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray<NSArray<PostItem *> *> *postItems;    // 首页数据

+ (instancetype)sharedManager;

- (BOOL)updateHomePosts;

@end
