//
//  HomePostsManager.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "HomePostsManager.h"
#import "Blogger.h"
#import "PostTag.h"
#import "PostComment.h"

@interface HomePostsManager ()

@property (nonatomic, strong)   NSURL   *tempURL;        // 暂时从我的博客中获取数据， 后续需升级为从服务器端获取数据

@property (nonatomic, strong) NSDictionary *json;

@end

@implementation HomePostsManager

+ (instancetype)sharedManager
{
    static HomePostsManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HomePostsManager alloc] initPriviate];
    });
    return manager;
}

- (instancetype)initPriviate
{
    self = [super init];
    if (self)
    {
        _tempURL = [NSURL URLWithString:@"http://yangxinlei.github.io/simple.json"];
        _postItems = [NSMutableArray array];
    }
    return self;
}

- (BOOL)updateHomePosts
{
    // Setup the session
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLRequest * request = [NSURLRequest requestWithURL:_tempURL];
    
    __block BOOL networkError = NO;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            networkError = YES;
            return ;
        }
        
        // Parse the JSON from the data object
        _json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self setupPostItemsWithJSON:_json];
    }];
    
    [dataTask resume];
    return !networkError;
}

- (void)setupPostItemsWithJSON:(NSDictionary *)json
{
    NSDictionary *bloggerDic = json[@"blogger"];
    Blogger *blogger = [[Blogger alloc] initWithName:bloggerDic[@"name"] url:bloggerDic[@"url"]];
    NSDictionary *twitterDic = json[@"twitter"];
    Blogger *twitter = [[Blogger alloc] initWithName:twitterDic[@"name"] url:twitterDic[@"url"]];

    NSMutableArray *tmpPosts = [NSMutableArray array];
    for (NSDictionary *post in json[@"posts"])
    {
        NSArray *commentsJson = post[@"comments"];
        NSMutableArray<PostComment *> *postComments = [NSMutableArray arrayWithCapacity:3];
        for (NSDictionary *comment in commentsJson)
        {
            PostComment *tmpComment = [[PostComment alloc] initWithPost:nil Blogger:blogger Content:comment[@"comment"] Date:comment[@"date"]];
            [postComments addObject:tmpComment];
        }
        
        PostItem *postItem = [[PostItem alloc] initWithTitle:post[@"title"]
                                                         Url:post[@"url"]
                                                     Blogger:blogger
                                                     Twitter:twitter
                                                         Tag:[[PostTag alloc] initWithName:post[@"tags"]]
                                                    Comments:postComments
                                                       Likes:[post[@"likes"] intValue]
                                                        Date:post[@"date"]];
        
        [tmpPosts addObject:postItem];
    }
    
    // 方法1:注册监听
//    dispatch_async(dispatch_get_main_queue(), ^(){
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeDataUpdated" object:nil];
//    });
    
    // 方法2:kvo
    dispatch_async(dispatch_get_main_queue(), ^(){
     [self setPostItems:[tmpPosts copy]];
    });
}

@end
