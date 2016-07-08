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

#define CELLREUSE_TOPCELL           @"cr_topTVCell"
#define CELL_REUSE_POSTCELL         @"cr_postTVCell"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:TITLE_HOMEPAGE];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _posts = [NSArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor redColor]];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:CELL_REUSE_POSTCELL];
    
    [self.view addSubview:_tableView];
    
    [[HomePostsManager sharedManager] updateHomePosts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeDataUpdated) name:@"HomeDataUpdated" object:nil];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)homeDataUpdated
{
    _posts = [[HomePostsManager sharedManager] postItems];
    
    if (_tableView != nil)
    {
        [_tableView reloadData];
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

@end
