//
//  PostDetailViewController.m
//  gIT pages
//
//  Created by xl on 16/7/10.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "PostDetailViewController.h"
#import "PostItem.h"

@interface PostDetailViewController ()

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
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopAndBack)];
//    [[self navigationItem] setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtnClicked)];
    [[self navigationItem] setRightBarButtonItem:rightItem];
    
    _postWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[_post url]];
    [_postWebView loadRequest:request];
    
    [self.view addSubview:_postWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    [[self navigationController] setHidesBarsOnSwipe:YES];
    
    // 隐藏状态栏
    UITabBarController *rootTabBarVC = (UITabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    [[rootTabBarVC tabBar] setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 重新设置导航栏隐藏模式
    [[self navigationController] setHidesBarsOnSwipe:NO];
    
    // 重新显示状态栏
    UITabBarController *rootTabBarVC = (UITabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    [[rootTabBarVC tabBar] setHidden:NO];
}

#pragma mark - 导航栏按钮动作

//- (void)stopAndBack
//{
//    [_postWebView stopLoading];
////    [_postWebView removeFromSuperview];
////    _postWebView = nil;
//    [[self navigationController] popViewControllerAnimated:YES];
//}

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
