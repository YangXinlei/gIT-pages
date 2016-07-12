//
//  PostDetailViewController.m
//  gIT pages
//
//  Created by xl on 16/7/10.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostDetailViewController.h"
#import "CommentView.h"
#import "PostItem.h"
#import "PostComment.h"
#import "CommentsViewController.h"
#import "Defs.h"

#define HEADER_INFO_HEIGHT                  40.0

@interface PostDetailViewController ()

@property (nonatomic, strong) UIToolbar *toobar;                                    // 底部工具栏
@property (nonatomic, strong) UIBarButtonItem *stopItem;                            // 工具栏停止加载按钮
@property (nonatomic, strong) UIBarButtonItem *refreshItem;                         // 工具栏网页刷新按钮
@property (nonatomic, strong) UIBarButtonItem *shareItem;                           // 工具栏分享文章按钮
@property (nonatomic, strong) UIBarButtonItem *commentItem;                         // 工具栏文章评论按钮
@property (nonatomic, strong) UIActivityIndicatorView *loadHomeDataIndicator;       // 数据加载指示器

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
    _stopItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopBtnClicked)];
    _refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshBtnClicked)];
    _shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtnClicked)];
    _commentItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(commentBtnClicked)];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [_toobar setItems:@[fixedSpace, _stopItem,
                        flexibleSpace, _refreshItem,
                        flexibleSpace, _shareItem,
                        flexibleSpace, _commentItem,
                        fixedSpace]];
    
    [self.view addSubview:_toobar];
    
    // 设置webView
    _postWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, SUBVIEW_HEIGHT - ASSERT_TABBAR_HEIGHT)];
    [_postWebView setBackgroundColor:LEMON_MAIN_COLOR];
    [_postWebView setDelegate:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:[_post url]];
    [_postWebView loadRequest:request];
    [[_postWebView scrollView] setDelegate:self];
    [self.view addSubview:_postWebView];
    
    // 添加加载指示器
    _loadHomeDataIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_loadHomeDataIndicator setColor:LEMON_MAIN_COLOR];
    [_loadHomeDataIndicator setCenter:CGPointMake(self.view.center.x, self.view.center.y - (ASSERT_NAVBAR_HEIGHT + ASSERT_TABBAR_HEIGHT + STATUSBAR_HEIGHT) / 2.0)];
    [_loadHomeDataIndicator setHidesWhenStopped:YES];
    [self.view addSubview:_loadHomeDataIndicator];
    
    [self.view bringSubviewToFront:_toobar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航栏，工具栏按钮动作

// 停止
- (void)stopBtnClicked
{
    [_postWebView stopLoading];
    
    [_stopItem setEnabled:NO];
    
    // 停止加载指示器
    if (_loadHomeDataIndicator != nil && [_loadHomeDataIndicator isAnimating])
    {
        [_loadHomeDataIndicator stopAnimating];
    }
}

// 刷新
- (void)refreshBtnClicked
{
    [_postWebView reload];
}

// 后退
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

// 前进
- (void)goForwardBtnClicked
{
    if ([_postWebView canGoForward])
    {
        [_postWebView goForward];
    }
}

// 点赞
- (void)likeBtnClicked:(UIBarButtonItem *)sender
{
    [sender setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)[_post likes] + 1]];
}

// 评论
- (void)commentBtnClicked
{
    // 隐藏push的新界面的tabbar
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:[[CommentsViewController alloc] initWithComments:[_post comments]] animated:YES];
}

// 分享
- (void) shareBtnClicked
{
    NSString *textToShare = [_post title];
    NSURL *urlToShare = [_post url];
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [activityVC.view setTintColor:LEMON_MAIN_COLOR];
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_stopItem setEnabled:YES];
    [_refreshItem setEnabled:NO];
    
    [_loadHomeDataIndicator startAnimating];
    
    [[self navigationItem] setTitle:[_post title]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_stopItem setEnabled:NO];
    [_refreshItem setEnabled:YES];
    
    // 停止加载指示器
    if (_loadHomeDataIndicator != nil && [_loadHomeDataIndicator isAnimating])
    {
        [_loadHomeDataIndicator stopAnimating];
    }

//    // 设置底部评论
//    CGFloat yStart = [[_postWebView scrollView] contentSize].height;
//    for (PostComment *commentItem in [_post comments])
//    {
//        CommentView *commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, yStart, WINDOW_WIDTH, 0) PostComment:commentItem];
//        
//        [_postWebView addSubview:commentView];
//        
//        yStart += [commentView frame].size.height;
//    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[self navigationItem] setTitle:@"加载失败"];
    [_refreshItem setEnabled:YES];
}

@end
