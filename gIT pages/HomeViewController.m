//
//  HomeViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "Defs.h"
#import "HomeViewController.h"
#import "TopTableViewCell.h"
#import "PostTableViewCell.h"
#import "HomePostsManager.h"

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
    
    [[HomePostsManager sharedManager] updateHomePosts];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView registerClass:[TopTableViewCell class] forCellReuseIdentifier:CELLREUSE_TOPCELL];
    [_tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:CELL_REUSE_POSTCELL];
    
    [self.view addSubview:_tableView];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - table view data sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[HomePostsManager sharedManager] postItems] objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostItem *item = [[[[HomePostsManager sharedManager] postItems] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row == 0)   // 轮播海报
    {
        cell = [_tableView dequeueReusableCellWithIdentifier:CELLREUSE_TOPCELL forIndexPath:indexPath];
    }
    else
    {
        cell = [_tableView dequeueReusableCellWithIdentifier:CELL_REUSE_POSTCELL forIndexPath:indexPath];
    }
    [cell.textLabel setText:item.title];
    [cell.detailTextLabel setText:item.title];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[HomePostsManager sharedManager] postItems] count];
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)   // 轮播海报
    {
        return 100;
    }
    return 50;
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
