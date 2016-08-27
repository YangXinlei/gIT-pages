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
#import "ToTopBtnView.h"

#define CELLREUSE_TOPCELL           @"cr_topTVCell"
#define CELL_REUSE_POSTCELL         @"cr_postTVCell"

@interface HomeViewController ()

@property (nonatomic, strong) UIActivityIndicatorView   *loadHomeDataIndicator;       // App启动后，首页数据加载指示器
@property (nonatomic, strong) UIRefreshControl          *refreshControl;                     // 下拉刷新控件
@property (nonatomic) BOOL                              isToTopBtnShowing;
@property (nonatomic, strong) ToTopBtnView              *toTopBtnView;

@end

@implementation HomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:TITLE_HOMEPAGE];
    [self.view setBackgroundColor:LEMON_MAIN_COLOR];
    
    _isToTopBtnShowing = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, SUBVIEW_HEIGHT - ASSERT_TABBAR_HEIGHT) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:LEMON_TINT_COLOR];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:CELL_REUSE_POSTCELL];
    
    [self.view addSubview:_tableView];
    
    _toTopBtnView = [[ToTopBtnView alloc] initWithFrame:CGRectMake(WINDOW_WIDTH - TOTOPBTN_SIZE - TOTOPBTN_MARGIN, SUBVIEW_HEIGHT - ASSERT_TABBAR_HEIGHT - TOTOPBTN_SIZE - TOTOPBTN_MARGIN, TOTOPBTN_SIZE, TOTOPBTN_SIZE)];
    
    // 下拉刷新
    [self setupRefreshControl];
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toTopBtnClicked) name:kToTopNotification object:nil];
    // 获取postItems
    [[HomePostsManager sharedManager] updateHomePosts];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 下拉刷新／上拉加载

- (void)setupRefreshControl
{
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    
    [_tableView addSubview:_refreshControl];
}

- (void)refreshAction:(UIRefreshControl *)refreshControl
{
    // 获取postItems
    [[HomePostsManager sharedManager] updateHomePosts];
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
        
        // 停止加载指示器
        if (_loadHomeDataIndicator != nil && [_loadHomeDataIndicator isAnimating])
        {
            [_loadHomeDataIndicator stopAnimating];
        }
        
        // 停止下拉刷新指示器
        if (_refreshControl != nil && [_refreshControl isRefreshing])
        {
            [_refreshControl endRefreshing];
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
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setTintColor:LEMON_MAIN_COLOR];
    
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
    PostTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    // 隐藏push的新界面的tabbar
    [self setHidesBottomBarWhenPushed:YES];
    
    // 压入文章内容VC
    PostItem *item = [_posts objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:[[PostDetailViewController alloc] initWithPostItem:item]animated:YES];
    
    // pop回来以后重新显示toobar
    [self setHidesBottomBarWhenPushed:NO];
}
#pragma mark setters & getters

- (void)setIsToTopBtnShowing:(BOOL)isToTopBtnShowing
{
    _isToTopBtnShowing = isToTopBtnShowing;
    if (_isToTopBtnShowing == YES)
    {
        [self.view addSubview:_toTopBtnView];
        [_toTopBtnView appearWithDuration:1.0];
    }
    else
    {
        [_toTopBtnView disappearAndRemoveWithDuration:0.5];
    }
}


#pragma mark scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollOffset: %@", NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat yOffset = [scrollView contentOffset].y;
    if (yOffset > 0 && !_isToTopBtnShowing)
    {
        [self setIsToTopBtnShowing:YES];
    }
    else if (yOffset <= 0)
    {
        if (_isToTopBtnShowing == YES)
        {
            [self setIsToTopBtnShowing:NO];
        }
    }
}

#pragma  mark notifications

- (void)toTopBtnClicked
{
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
@end
