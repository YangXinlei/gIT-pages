//
//  HomeViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "Defs.h"
#import "HomeViewController.h"
#import "PostTableViewCell.h"
#import "HomePostsManager.h"
#import "Blogger.h"
#import "PostComment.h"
#import "PostTag.h"
#import "PostDetailViewController.h"

#define CELLREUSE_TOPCELL           @"cr_topTVCell"
#define CELL_REUSE_POSTCELL         @"cr_postTVCell"

@interface HomeViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *loadHomeDataIndicator;       // App启动后，首页数据加载指示器

@end

@implementation HomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:TITLE_HOMEPAGE];
    [self.view setBackgroundColor:LEMON_MAIN_COLOR];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_tableView setBackgroundColor:LEMON_TINT_COLOR];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:CELL_REUSE_POSTCELL];
    
    [self.view addSubview:_tableView];
    
    // 添加加载指示器
    _loadHomeDataIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_loadHomeDataIndicator setColor:LEMON_BLUE_COLOR];
    [_loadHomeDataIndicator setCenter:CGPointMake(self.view.center.x, self.view.center.y - (ASSERT_NAVBAR_HEIGHT + ASSERT_TABBAR_HEIGHT + STATUSBAR_HEIGHT) / 2.0)];
    [_loadHomeDataIndicator setHidesWhenStopped:YES];
    [self.view addSubview:_loadHomeDataIndicator];
    [_loadHomeDataIndicator startAnimating];
    
    _posts = [NSArray array];
    // 监听postItems
    [[HomePostsManager sharedManager] addObserver:self forKeyPath:@"postItems" options:NSKeyValueObservingOptionNew context:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeDataUpdated) name:@"HomeDataUpdated" object:nil];
    // 获取postItems
    [[HomePostsManager sharedManager] updateHomePosts];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 监听到postItems变化

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"postItems"])
    {
        [self homeDataUpdated];
    }
}

- (void)homeDataUpdated
{
    _posts = [[HomePostsManager sharedManager] postItems];
    
    if (_tableView != nil)
    {
        [_tableView reloadData];
        
        if (_loadHomeDataIndicator != nil && [_loadHomeDataIndicator isAnimating])
        {
            [_loadHomeDataIndicator stopAnimating];
        }
    }
}

#pragma mark - table view data sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_posts count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostItem *item = [_posts objectAtIndex:indexPath.row];
    
    PostTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CELL_REUSE_POSTCELL forIndexPath:indexPath];
    
    [cell setupWithPostItem:item];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HOME_POSTCELL_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    [self setHidesBottomBarWhenPushed:YES];
    // 压入文章内容VC
    PostItem *item = [_posts objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:[[PostDetailViewController alloc] initWithPostItem:item]animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
@end
