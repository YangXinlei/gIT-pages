//
//  CommentsViewController.m
//  gIT pages
//
//  Created by xl on 16/7/11.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentCell.h"
#import "CommentView.h"
#import "PostComment.h"
#import "Defs.h"

#define COMMENTCELL_ID              @"CommentCell_ID"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (instancetype)initWithComments:(NSArray<PostComment *> *)comments
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        _comments = comments;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationItem] setTitle:@"评论"];
    
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:COMMENTCELL_ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view data sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_comments count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:COMMENTCELL_ID forIndexPath:indexPath];
    
    [cell setupWithComment:[_comments objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentView *tmpView = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 0) PostComment:[_comments objectAtIndex:indexPath.row]];
    
    return [tmpView frame].size.height;
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
    
}



@end
