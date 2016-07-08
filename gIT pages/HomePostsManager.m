//
//  HomePostsManager.m
//  gIT pages
//
//  Created by xl on 16/7/7.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "HomePostsManager.h"

@interface HomePostsManager ()

@property (nonatomic, strong)   NSURL   *tempURL;        // 暂时从我的博客中获取数据， 后续需升级为从服务器端获取数据
@property (nonatomic, strong) NSMutableArray   *allPosts;
@property (nonatomic, strong) PostItem  *curPost;
@property (nonatomic, strong) NSString  *curElementName;
@property (nonatomic, assign) BOOL      startParseItem;
@property (nonatomic, strong) NSMutableString  *tmpString;

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
    }
    return self;
}

- (BOOL)updateHomePosts
{
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:_tempURL];
    [xmlParser setDelegate:self];
    return [xmlParser parse];
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _postItems = [NSMutableArray array];
    _allPosts = [NSMutableArray array];
    _curPost = [[PostItem alloc] init];
    _curElementName = @"";
    _startParseItem = NO;
    _tmpString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    
    _curElementName = elementName;
    if ([elementName isEqualToString:@"item"])
    {
        _startParseItem = YES;
        _tmpString = [NSMutableString string];
        _curPost = [[PostItem alloc] init];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_startParseItem && [_curElementName isEqualToString:@"title"])
    {
        [_tmpString appendString:string];
    }
    else if (_startParseItem && [_curElementName isEqualToString:@"link"])
    {
        NSString *prefix = @"http://yourdomain.com";
        NSString *suffix = nil;
        if ([string hasPrefix:prefix])
        {
            suffix = [string substringFromIndex:[prefix length] - 1];
        }
        [_curPost setUrl:[NSURL URLWithString:[NSString stringWithFormat:@"http://yangxinlei.github.io%@", suffix]]];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        _startParseItem = NO;
        [_allPosts addObject:_curPost];
    }
    else if (_startParseItem && [elementName isEqualToString:@"title"])
    {
        [_curPost setTitle:_tmpString];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    int index = 0;
    NSMutableArray *suggestPosts = [NSMutableArray array];
    for (; index < 2 && index < [_allPosts count]; ++index)
    {
        [suggestPosts addObject:_allPosts[index]];
    }
    [_postItems addObject:suggestPosts];
    
    if (index < [_allPosts count])
    {
        NSMutableArray *remainPosts = [NSMutableArray array];
        for (; index < [_allPosts count]; ++index)
        {
            [remainPosts addObject:_allPosts[index]];
        }
        [_postItems addObject:remainPosts];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"parse error");
}

@end
