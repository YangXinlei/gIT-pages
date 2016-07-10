//
//  PostDetailViewController.m
//  gIT pages
//
//  Created by xl on 16/7/10.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostDetailViewController.h"
#import "PostItem.h"
#import "Defs.h"

@interface PostDetailViewController ()

@property (nonatomic, strong) UIToolbar *toobar;

@end

@implementation PostDetailViewController

- (instancetype)initWithPostItem:(PostItem *)post
{
    self = [super init];
    if (self)
    {
        _post = post;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [[self navigationItem] setTitle:[_post title]];
    
    // 设置工具栏
    _toobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SUBVIEW_HEIGHT - ASSERT_TABBAR_HEIGHT, WINDOW_WIDTH, ASSERT_TABBAR_HEIGHT)];
    [_toobar setTintColor:LEMON_MAIN_COLOR];
//   UIBarButtonItem *goBackItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(goBackBtnClicked)];
//    UIBarButtonItem *goForwardItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(goForwardBtnClicked)];
    UIBarButtonItem *stopItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopBtnClicked)];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshBtnClicked)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtnClicked)];
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(commentBtnClicked)];
    
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [_toobar setItems:@[fixedSpace, stopItem,
                        flexibleSpace, refreshItem,
                        flexibleSpace, shareItem,
                        flexibleSpace, commentItem,
                        fixedSpace]];
    
    [self.view addSubview:_toobar];
    
    _postWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, SUBVIEW_HEIGHT - ASSERT_TABBAR_HEIGHT)];
    [_postWebView setBackgroundColor:LEMON_MAIN_COLOR];
    NSURLRequest *request = [NSURLRequest requestWithURL:[_post url]];
    [_postWebView loadRequest:request];
    
    [self.view addSubview:_postWebView];
    
    [self.view bringSubviewToFront:_toobar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航栏，工具栏按钮动作

- (void)stopBtnClicked
{
    [_postWebView stopLoading];
}

- (void)refreshBtnClicked
{
    [_postWebView reload];
}

- (void)goBackBtnClicked
{
    if ([_postWebView canGoBack])
    {
        [_postWebView goBack];
        
        // 后退之后检查是否还能后退
        if (![_postWebView canGoBack])
        {
            UIBarButtonItem *item = [[_toobar items] objectAtIndex:0];
            [item setEnabled:NO];
        }
    }
}

- (void)goForwardBtnClicked
{
    if ([_postWebView canGoForward])
    {
        [_postWebView goForward];
    }
}

- (void)likeBtnClicked:(UIBarButtonItem *)sender
{
    [sender setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)[_post likes] + 1]];
}

- (void)commentBtnClicked
{
    
}

- (void) shareBtnClicked
{
    NSString *textToShare = [_post title];
    NSURL *urlToShare = [_post url];
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
