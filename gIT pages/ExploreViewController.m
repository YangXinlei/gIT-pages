//
//  ExploreViewController.m
//  gIT pages
//
//  Created by xl on 16/7/6.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ExploreViewController.h"
#import "BloggerTableViewCell.h"
#import "Defs.h"

#define CELL_REUSE_BLOGGERCELL      @"cr_bloggerCell"

@interface ExploreViewController ()

@end


@implementation ExploreViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:LEMON_TINT_COLOR];
    [[[self navigationController] navigationBar] setTintColor:LEMON_TINT_COLOR];
    [[self navigationItem] setTitle:@"发现"];
    
    [self.tableView registerClass:[BloggerTableViewCell class] forCellReuseIdentifier:CELL_REUSE_BLOGGERCELL];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - table view data sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BloggerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSE_BLOGGERCELL forIndexPath:indexPath];
    
    Blogger *b = [[Blogger alloc] initWithName:@"杨鑫磊" url:@"yangxinlei.github.io"];
    [cell setupWithBlogger:b];
    
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
}


@end
